// app/javascript/application.js

// Turbo (Hotwired)
import "@hotwired/turbo-rails";
import "controllers"

// Bootstrap & Popper
import "bootstrap";
import { Tooltip, Popover } from "bootstrap";

// Typeahead for autocomplete
import "typeahead.js/dist/typeahead.bundle";

// Blacklight JS (from engine or pinned in importmap)
import Blacklight from "blacklight";

// Grenander engine JS
import "grenander/search_sources_menu";

// Optional: Blacklight Range Limit
import BlacklightRangeLimit from "blacklight-range-limit";

import Rails from "@rails/ujs";
Rails.start();
