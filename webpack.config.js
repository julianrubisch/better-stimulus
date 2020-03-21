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
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
            plugins: [
              "@babel/plugin-transform-runtime",
              "@babel/plugin-proposal-class-properties"
            ]
          }
        }
      }
    ]
  }
};

module.exports = config;
