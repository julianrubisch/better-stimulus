import { Application } from "stimulus";
import { CopyController } from "@hopsoft/controllers";
import { definitionsFromContext } from "stimulus/webpack-helpers";

import CodeAreaInstrumentationController from "./controllers/code_area_instrumentation_controller";

const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

document.body.dataset.controller = "code-area-instrumentation";
document.addEventListener("turbolinks:load", e => {
  document.body.dataset.controller = "code-area-instrumentation";
});
