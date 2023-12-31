import {
  SIDE_NAV_LIGHT,
  NAV_TYPE_SIDE,
  DIR_LTR,
} from "constants/ThemeConstant";
import { env, server_ip } from "./EnvironmentConfig";

export const APP_NAME = "Admin Gilgamesj";
export const API_BASE_URL =
  env.API_ENDPOINT_URL || `http://${server_ip}:4000/admin/api/v1`;
export const BASE_URL = env.ENDPOINT_URL || `http://${server_ip}:4000/`;
export const APP_PREFIX_PATH = "/app";
export const AUTH_PREFIX_PATH = "/auth";

export const THEME_CONFIG = {
  navCollapsed: false,
  sideNavTheme: SIDE_NAV_LIGHT,
  locale: "en",
  navType: NAV_TYPE_SIDE,
  topNavColor: "#405360",
  headerNavColor: "",
  mobileNav: false,
  currentTheme: "light",
  direction: DIR_LTR,
};

export const colorPrimary = "#79684B";
