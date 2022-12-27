import "./app.css";
import App from "./App.svelte";

import relativeTime from "dayjs/plugin/relativeTime";
// import utc from "dayjs/plugin/utc";
import * as dayjs from "dayjs";

dayjs.extend(relativeTime);
// dayjs.extend(utc);

const app = new App({
    target: document.getElementById("app"),
});

export default app;
