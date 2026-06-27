import type { FC, SVGProps } from "react";
import type { IconKey } from "@/lib/content";

type IconProps = SVGProps<SVGSVGElement>;

const Base: FC<IconProps> = ({ children, ...props }) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth={1.75}
    strokeLinecap="round"
    strokeLinejoin="round"
    {...props}
  >
    {children}
  </svg>
);

export const CalendarIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M4 7a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12z" />
    <path d="M16 3v4" />
    <path d="M8 3v4" />
    <path d="M4 11h16" />
    <path d="M8 14v4" />
    <path d="M12 14v4" />
    <path d="M16 14v4" />
  </Base>
);

export const CheckIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M5 12l5 5l10 -10" />
  </Base>
);

export const UsersIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M10 13a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
    <path d="M8 21v-1a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v1" />
    <path d="M15 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
    <path d="M17 10h2a2 2 0 0 1 2 2v1" />
    <path d="M5 5a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
    <path d="M3 13v-1a2 2 0 0 1 2 -2h2" />
  </Base>
);

export const SyncIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M19.933 13.041a8 8 0 1 1 -9.925 -8.788c3.899 -1 7.935 1.007 9.425 4.747" />
    <path d="M20 4v5h-5" />
  </Base>
);

export const BellIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M12.5 17h-8.5a4 4 0 0 0 2 -3v-3a7 7 0 0 1 4 -6a2 2 0 1 1 4 0a7 7 0 0 1 4 6v1" />
    <path d="M9 17v1a3 3 0 0 0 3.49 2.96" />
    <path d="M19 22v-6" />
    <path d="M22 19l-3 -3l-3 3" />
  </Base>
);

export const CrownIcon: FC<IconProps> = (p) => (
  <Base {...p}>
    <path d="M12 6l4 6l5 -4l-2 10h-14l-2 -10l5 4z" />
  </Base>
);

export const iconMap: Record<IconKey, FC<IconProps>> = {
  calendar: CalendarIcon,
  check: CheckIcon,
  users: UsersIcon,
  sync: SyncIcon,
  bell: BellIcon,
  crown: CrownIcon,
};
