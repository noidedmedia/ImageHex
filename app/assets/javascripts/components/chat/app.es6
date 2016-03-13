import { combineReducers } from 'redux';
import * as reducers from './reducers.es6';

var chatApp = combineReducers(reducers);
export { chatApp };
