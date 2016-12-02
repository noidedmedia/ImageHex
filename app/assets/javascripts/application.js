import 'babel-polyfill';
import $ from 'jquery';
window.$ = $;
import Turbolinks from 'turbolinks';
window.Turbolinks = Turbolinks;
import ReactUJS from './react_ujs';
import './components.js';

Turbolinks.start();
ReactUJS.setup();
