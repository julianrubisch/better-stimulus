import { Application } from "stimulus";

import CodeAreaInstrumentationController from "./controllers/code_area_instrumentation_controller";

const application = Application.start();
application.register(
  "code-area-instrumentation",
  CodeAreaInstrumentationController
);

document.body.dataset.controller = "code-area-instrumentation";
document.addEventListener("turbolinks:load", e => {
  document.body.dataset.controller = "code-area-instrumentation";
});
