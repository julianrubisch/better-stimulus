import { Application } from "stimulus";

import CodeAreaInstrumentationController from "./controllers/code_area_instrumentation_controller";

const application = Application.start();
application.register(
  "code-area-instrumentation",
  CodeAreaInstrumentationController
);

// document.addEventListener("turbolinks:load", () => {
//   document.body.dataset.controller = "code-area-instrumentation";
// });
document.addEventListener("DOMContentLoaded", () => {
  document.body.dataset.controller = "code-area-instrumentation";
});
