import { configureStore } from "@reduxjs/toolkit";
import userSlice, { user } from "./user/userSlice";

export const store = configureStore({
  reducer: {
    [user]: userSlice,
  },
});
