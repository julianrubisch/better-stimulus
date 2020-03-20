import { Application } from "stimulus";
import CopyController from "@hopsoft/copy-controller";

import CodeAreaInstrumentationController from "./controllers/code_area_instrumentation_controller";

const application = Application.start();
application.register(
  "code-area-instrumentation",
  CodeAreaInstrumentationController
);
application.register("copy", CopyController);

document.body.dataset.controller = "code-area-instrumentation";
document.addEventListener("turbolinks:load", e => {
  document.body.dataset.controller = "code-area-instrumentation";
});
