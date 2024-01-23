import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  email: "",
  user_type_id: "",
};

export const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    setUser(state, action) {
      const { id, email, user_type_id } = action.payload;
      return {
        id,
        email,
        user_type_id,
      };
    },
    clearUser(state, action) {
      return { id: "", email: "", user_type_id: "" };
    },
  },
});

export const { setUser, clearUser } = userSlice.actions;
export const user = userSlice.name;
export default userSlice.reducer;
export const extractUserSlice = (global) => {
  return global[user];
};
