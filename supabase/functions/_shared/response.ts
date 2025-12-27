export const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

export const createErrorResponse = (
  message: string,
  status = 400,
  originalError?: unknown,
) => {
  // Log errors to the console for debugging (visible in the Logs tab)
  console.error(`[Error] Status: ${status}, Message: ${message}`);
  if (originalError) {
    console.error("Function error:", originalError);
  }

  return new Response(
    JSON.stringify({ error: message }),
    {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status,
    },
  );
};

// 400 Bad Request - for bad user input
export const createBadRequestResponse = (
  message: string,
  originalError?: unknown,
) => {
  return createErrorResponse(message, 400, originalError);
};

// 404 Not Found - when something doesn't exist
export const createNotFoundResponse = (
  message: string,
  originalError?: unknown,
) => {
  return createErrorResponse(message, 404, originalError);
};

// 500 Internal Server Error - for server errors
export const createInternalServerErrorResponse = (
  message: string,
  originalError?: unknown,
) => {
  return createErrorResponse(message, 500, originalError);
};

export const createSuccessResponse = <T>(data: T, status = 200) => {
  return new Response(
    JSON.stringify(data),
    {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status,
    },
  );
};
