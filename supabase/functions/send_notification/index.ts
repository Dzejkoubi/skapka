import { createClient } from "jsr:@supabase/supabase-js@2";

// ── FCM Auth ────────────────────────────────────────────────────────────────
// FCM HTTP v1 API requires a short-lived OAuth token generated from
// your service account — it cannot use the service account JSON directly.

// Native base64url — no external dependency needed
function base64url(data: Uint8Array): string {
  return btoa(String.fromCharCode(...data))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

async function getAccessToken(): Promise<string> {
  const serviceAccount = JSON.parse(Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!);

  const now = Math.floor(Date.now() / 1000);

  // Build the JWT header + claim set that Google expects
  const header = { alg: "RS256", typ: "JWT" };
  const claim = {
    iss: serviceAccount.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };

  const encode = (obj: object) =>
    base64url(new TextEncoder().encode(JSON.stringify(obj)));

  const unsigned = `${encode(header)}.${encode(claim)}`;

  // Sign with the private key from service account
  const privateKey = await crypto.subtle.importKey(
    "pkcs8",
    pemToArrayBuffer(serviceAccount.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const signature = base64url(
    new Uint8Array(
      await crypto.subtle.sign(
        "RSASSA-PKCS1-v1_5",
        privateKey,
        new TextEncoder().encode(unsigned)
      )
    )
  );

  const jwt = `${unsigned}.${signature}`;

  // Exchange the JWT for a short-lived access token
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  });

  const { access_token } = await res.json();
  return access_token;
}

// Helper — convert PEM string to ArrayBuffer for crypto.subtle
function pemToArrayBuffer(pem: string): ArrayBuffer {
  const base64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, "")
    .replace(/-----END PRIVATE KEY-----/, "")
    .replace(/\n/g, "");
  const binary = atob(base64);
  const buffer = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    buffer[i] = binary.charCodeAt(i);
  }
  return buffer.buffer;
}

// ── Main handler ─────────────────────────────────────────────────────────────

Deno.serve(async (req) => {
  const { account_id, title, body, data } = await req.json();

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  // Fetch the target user's FCM token from accounts table
  const { data: account, error } = await supabase
    .from("accounts")
    .select("fcm_token")
    .eq("account_id", account_id)
    .single();

  if (error || !account?.fcm_token) {
    return new Response(
      JSON.stringify({ error: "FCM token not found for this account" }),
      { status: 404 }
    );
  }

  const accessToken = await getAccessToken();
  const projectId = Deno.env.get("FIREBASE_PROJECT_ID")!;

  const fcmRes = await fetch(
    `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
    {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: {
          token: account.fcm_token,
          notification: { title, body },
          data: data ?? {},
        },
      }),
    }
  );

  const result = await fcmRes.json();
  return new Response(JSON.stringify(result), { status: fcmRes.status });
});