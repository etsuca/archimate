// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require('jquery')
import "./diagnosis/like_modal";
import "./diagnosis/new";
import "./shared/description";
import "./shared/hamburger_menu";
import "./shared/progress_bar";
import "./diagnosis/diagnosis_progress_bar";
import "./architecture/preview";
import "./architecture/keep_search_params";
import "./architecture/tag";
import "./architecture/search_range";
import "./registrations/edit";
import "./users/show";