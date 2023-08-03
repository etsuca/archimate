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
import '@fortawesome/fontawesome-free/js/all';
import "../javascripts/diagnosis/like_modal";
import "../javascripts/diagnosis/new";
import "../javascripts/shared/description";
import "../javascripts/shared/hamburger_menu";
import "../javascripts/shared/progress_bar";
import "../javascripts/shared/diagnosis_progress_bar";
import "../javascripts/architecture/preview";
import "../javascripts/registrations/edit";
import "../javascripts/users/show";