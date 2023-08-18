import { combineReducers } from 'redux'
import Auth from './Auth'
import Theme from './Theme'
import News from './News'
import Maps from './Maps'
import SocialMedia from './SocialMedia'
import SocialMediaComment from './SocialMediaComment'
import GalleryPhoto from './GalleryPhoto'
import GalleryVideo from './GalleryVideo'
import Chat from './Chat'
import ChatDetail from './ChatDetail'
import Camera from './Camera'
import Phone from './Phone'
import Contact from './Contact'
import Stage from './Stage'
import Task from './Task'
import Setting from './Setting'
import User from './User'
import Light from './Light'

const reducers = combineReducers({
  theme: Theme,
  auth: Auth,
  news: News,
  maps: Maps,
  socialMedia: SocialMedia,
  socialMediaComment: SocialMediaComment,
  SocialMediaComment: SocialMediaComment,
  galleryPhoto: GalleryPhoto,
  galleryVideo: GalleryVideo,
  chat: Chat,
  chatDetail: ChatDetail,
  camera: Camera,
  phone: Phone,
  contact: Contact,
  stage: Stage,
  task: Task,
  setting: Setting,
  user: User,
  light: Light,
})

export default reducers
