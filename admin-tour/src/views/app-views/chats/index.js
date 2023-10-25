import React from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import ChatList from "./chat-list";
import AddChat from "./add-chat";
import EditChat from "./edit-chat";
import DetailChatList from "./detail-chat/detail-chat-list";
import AddDetailChat from "./detail-chat/add-detail-chat";
import EditDetailChat from "./detail-chat/edit-detail-chat";

const Chat = (props) => {
  const { match } = props;
  return (
    <Switch>
      <Redirect exact from={`${match.url}`} to={`${match.url}/list-chat`} />
      <Route path={`${match.url}/add-chat`} component={AddChat} />
      <Route path={`${match.url}/edit-chat/:id`} component={EditChat} />
      <Route path={`${match.url}/list-chat`} component={ChatList} />
      <Route
        exact
        path={`${match.url}/detail-chat/:chatId`}
        component={DetailChatList}
      />
      <Route
        path={`${match.url}/detail-chat/:chatId/add`}
        component={AddDetailChat}
      />
      <Route
        path={`${match.url}/detail-chat/:chatId/:id/edit`}
        component={EditDetailChat}
      />
    </Switch>
  );
};

export default Chat;
