const webpack = require("webpack");
const path = require("path");

const config = {
  entry: "./_src/index.js",
  output: {
    path: path.resolve(__dirname, "assets/js"),
    filename: "index.js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: "babel-loader"
        // exclude: /node_modules/
      }
    ]
  }
};

module.exports = config;
