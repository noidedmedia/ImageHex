import 'babel-polyfill';
import $ from 'jquery';
window.$ = $;
import Turbolinks from 'turbolinks';
window.Turbolinks = Turbolinks;
import ReactUJS from './react_ujs';
import './components';
import './favorites';
import './header-menu';
import './in-place';
import './settings';
import './upload';
import './users';


Turbolinks.start();
ReactUJS.setup();
