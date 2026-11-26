(function () {
  "use strict";

  var SCENARIOS = {
    "seeded-finding": {
      title: "Seeded finding",
      blurb: "Gitleaks scanned the toy app and reported the one seeded EXAMPLE DATA token in toy/config.env.example. This is the expected demo result, not a real leak."
    },
    "clean-scan": {
      title: "Clean scan",
      blurb: "Gitleaks scanned toy/clean/, which has no tokens. The canned result is an empty finding list."
    },
    "allowlisted-path": {
      title: "Allowlisted path",
      blurb: "The same seeded token is present, but a narrow path allowlist in the example config suppresses toy/config.env.example, so the canned result is clean."
    }
  };

  var titleEl = document.getElementById("result-title");
  var statusEl = document.getElementById("result-status");
  var blurbEl = document.getElementById("result-blurb");
  var jsonEl = document.getElementById("result-json");
  var buttons = {
    "seeded-finding": document.getElementById("choice-seeded-finding"),
    "clean-scan": document.getElementById("choice-clean-scan"),
    "allowlisted-path": document.getElementById("choice-allowlisted-path")
  };

  function showFriendly(message) {
    statusEl.textContent = message;
    statusEl.className = "status friendly";
    jsonEl.textContent = "No raw error is shown. The canned example for this choice is unavailable right now.";
  }

  function showScenario(name, data) {
    var meta = SCENARIOS[name];
    titleEl.textContent = meta.title;
    statusEl.textContent = "Canned example — sample data only";
    statusEl.className = "status";
    blurbEl.textContent = meta.blurb;
    try {
      jsonEl.textContent = JSON.stringify(data, null, 2);
    } catch (err) {
      showFriendly("This canned scenario could not be displayed.");
    }
  }

  function select(name) {
    Object.keys(buttons).forEach(function (key) {
      buttons[key].setAttribute("aria-pressed", key === name ? "true" : "false");
    });
    titleEl.textContent = SCENARIOS[name].title;
    statusEl.textContent = "Loading the canned example…";
    statusEl.className = "status";
    blurbEl.textContent = "";
    jsonEl.textContent = "";

    fetch("scenarios/" + name + ".json")
      .then(function (res) {
        if (!res.ok) throw new Error("missing");
        return res.json();
      })
      .then(function (data) {
        showScenario(name, data);
      })
      .catch(function () {
        showFriendly("This canned scenario is missing. Please try another choice.");
      });
  }

  Object.keys(buttons).forEach(function (name) {
    buttons[name].addEventListener("click", function () {
      select(name);
    });
  });

  select("seeded-finding");
})();
