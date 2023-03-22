import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {HttpClientModule} from '@angular/common/http';
import {Ng2SearchPipeModule} from 'ng2-search-filter';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {MainComponent} from './layouts/main/main.component';
import {NavbarComponent} from './layouts/navbar/navbar.component';
import {NgxPaginationModule} from "ngx-pagination";
import {InitialScriptComponent} from "./initial/initial-script.component";


@NgModule({
  declarations: [
    AppComponent,
    MainComponent,
    NavbarComponent,
    InitialScriptComponent
  ],

  imports: [
    AppRoutingModule,
    BrowserModule,
    HttpClientModule,
    ReactiveFormsModule,
    NgbModule,
    Ng2SearchPipeModule,
    FormsModule,
    NgxPaginationModule
  ],

  providers: [],
  bootstrap: [AppComponent]
})

export class AppModule {
}
