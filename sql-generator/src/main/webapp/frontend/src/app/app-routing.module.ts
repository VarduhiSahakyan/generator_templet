import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {InitialScriptComponent} from "./initial/initial-script.component";


const routes: Routes = [
  {path: '', component: InitialScriptComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})

export class AppRoutingModule {
}
