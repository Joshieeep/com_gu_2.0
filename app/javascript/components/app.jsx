import React from "react";
import { createRoot } from "react-dom/client";
import Calendar from "./calendar";

// Clear the existing HTML content
// document.body.innerHTML = '<div id="app"></div>';
export default function App() {
  return <Calendar />;
}

// Render your React component instead
document.addEventListener("turbo:load", () => {
  const app = document.getElementById("app");
  
  if (app) {
  const root = createRoot(app);
  root.render(<App />);
}
  if (app) {
    const root = createRoot(app);
    root.render(<App />);

    document.addEventListener("turbo:before-visit", () => {
      root.unmount();
    });
  }
});