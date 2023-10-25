import {
  DashboardOutlined,
  UserOutlined,
  ContactsOutlined,
  PhoneOutlined,
  BarsOutlined,
  UsergroupAddOutlined,
  NumberOutlined,
  VideoCameraOutlined,
  FundOutlined,
  MessageOutlined,
  SettingOutlined,
  CheckSquareFilled,
  CameraOutlined,
  LinkOutlined,
  HomeOutlined,
} from '@ant-design/icons'
import { APP_PREFIX_PATH } from 'configs/AppConfig'

const dashBoardNavTree = [
  {
    key: 'dashboard',
    path: `${APP_PREFIX_PATH}/home`,
    title: 'home',
    icon: DashboardOutlined,
    breadcrumb: false,
    submenu: [],
  },
  {
    key: 'user',
    path: `${APP_PREFIX_PATH}/users`,
    title: 'User',
    icon: UserOutlined,
    breadcrumb: false,
    submenu: [],
  },
  {
    key: 'player',
    path: `${APP_PREFIX_PATH}/players`,
    title: 'Player',
    icon: UserOutlined,
    breadcrumb: false,
    submenu: [],
  },
  {
    key: 'theater',
    path: `${APP_PREFIX_PATH}/theaters`,
    title: 'Theater',
    icon: HomeOutlined,
    breadcrumb: false,
    submenu: [],
  },
  // {
  //   key: "news",
  //   path: `${APP_PREFIX_PATH}/news`,
  //   title: "Browser",
  //   icon: BarsOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "social-media",
  //   path: `${APP_PREFIX_PATH}/social-medias`,
  //   title: "Social Media",
  //   icon: UsergroupAddOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "gallery-photos",
  //   path: `${APP_PREFIX_PATH}/gallery-photos`,
  //   title: "Gallery Photo",
  //   icon: NumberOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "gallery-videos",
  //   path: `${APP_PREFIX_PATH}/gallery-videos`,
  //   title: "Gallery Video",
  //   icon: VideoCameraOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "map",
  //   path: `${APP_PREFIX_PATH}/maps`,
  //   title: "Map",
  //   icon: FundOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "camera",
  //   path: `${APP_PREFIX_PATH}/cameras`,
  //   title: "Camera",
  //   icon: CameraOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },

  // {
  //   key: "chat",
  //   path: `${APP_PREFIX_PATH}/chats`,
  //   title: "Chat",
  //   icon: MessageOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "phone",
  //   path: `${APP_PREFIX_PATH}/phones`,
  //   title: "Phone",
  //   icon: PhoneOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "contact",
  //   path: `${APP_PREFIX_PATH}/contacts`,
  //   title: "Contact",
  //   icon: ContactsOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "stage",
  //   path: `${APP_PREFIX_PATH}/stages`,
  //   title: "Stage",
  //   icon: CheckSquareFilled,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "pre-game",
  //   path: `${APP_PREFIX_PATH}/pre-games`,
  //   title: "Pre Game",
  //   icon: CheckSquareFilled,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  // {
  //   key: "light",
  //   path: `${APP_PREFIX_PATH}/lights`,
  //   title: "Light",
  //   icon: LinkOutlined,
  //   breadcrumb: false,
  //   submenu: [],
  // },
  {
    key: 'setting',
    path: `${APP_PREFIX_PATH}/settings`,
    title: 'Setting',
    icon: SettingOutlined,
    breadcrumb: false,
    submenu: [],
  },
]

const navigationConfig = [...dashBoardNavTree]

export default navigationConfig