function count_of_days(year, month) {
    return 33 - new Date(year, month, 33).getDate();
};

function set_count_of_days() {
    year = document.getElementById("event_time_of_event_1i").value;
    month = document.getElementById("event_time_of_event_2i").value;

    count = count_of_days(year, month - 1);

    days = document.getElementById("event_time_of_event_3i");
    days.innerHTML = ""

    for (i = 1; i <= count; i++) {
        days.innerHTML = days.innerHTML + "<option value=" + i + ">" + i + "</option>\n"
    }
};


set_count_of_days()
year = document.getElementById("event_time_of_event_1i");
month = document.getElementById("event_time_of_event_2i");

year.setAttribute("onclick", "set_count_of_days()");
month.setAttribute("onclick", "set_count_of_days()");
document.getElementById("event_time_of_event_3i").value = new Date().getDate();