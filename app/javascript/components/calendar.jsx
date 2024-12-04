import React, { useState, useEffect } from "react";
import FullCalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";

export default function Calendar() {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const scriptTag = document.getElementById("events");

    if (scriptTag) {
      const data = JSON.parse(scriptTag.textContent.trim());
      setEvents(data);
    }
  }, []);
  return (
    <FullCalendar
      plugins={[dayGridPlugin]}
      initialView="dayGridMonth"
      weekends={true}
      events={events}
    />
  );
}