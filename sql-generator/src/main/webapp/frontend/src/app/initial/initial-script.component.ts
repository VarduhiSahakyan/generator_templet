import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {InitialScriptService} from "./initial-script.service";
import Swal from "sweetalert2";

@Component({
  selector: 'app-sql-generator',
  templateUrl: './initial-script.component.html',
  styleUrls: ['./initial-script.component.css']
})
export class InitialScriptComponent implements OnInit {

  sqlScript: any;
  disableGenerateButton1: boolean = true;
  disableUploadButton1: boolean = true;
  disableRadioButtonUpdate1: boolean = true;
  showSuccessMsg: boolean = false;
  initialFileJson01: File = {} as File;
  errorMessage: string = '';
  selectedSqlMode1: string = 'insert';
  @ViewChild("inputFile1") inputFile1: ElementRef = {} as ElementRef;
  @ViewChild("sqlModeInsert1") sqlModeInsert1: ElementRef = {} as ElementRef;
  @ViewChild("sqlModeUpdate1") sqlModeUpdate1: ElementRef = {} as ElementRef;
  disableGenerateButton2: boolean = true;
  disableUploadButton2: boolean = true;
  disableRadioButtonUpdate2: boolean = true;
  showSuccessMsg2: boolean = false;
  initialFileJson02: File = {} as File;
  errorMessage2: string = '';
  selectedSqlMode2: string = 'insert';
  @ViewChild("inputFile2") inputFile2: ElementRef = {} as ElementRef;
  @ViewChild("sqlModeInsert2") sqlModeInsert2: ElementRef = {} as ElementRef;
  @ViewChild("sqlModeUpdate2") sqlModeUpdate2: ElementRef = {} as ElementRef;

  constructor(private sqlGeneratorService: InitialScriptService) {
  }

  ngOnInit(): void {
  }

  selectInitialFileJson01(inputFile1: any, event: any) {
    this.initialFileJson01 = event.target.files[0];
    this.showSuccessMsg = false;
    if (this.initialFileJson01.type == 'application/json') {
      this.disableUploadButton1 = false;
    } else {
      Swal.fire("You can select only JSON file");
      inputFile1.value = '';
    }
  }

  uploadInitialFileJson01() {
    this.disableGenerateButton1 = false;
    this.errorMessage = '';
    this.sqlGeneratorService.uploadInitialFileJson1(this.initialFileJson01).subscribe(res => {
      this.showSuccessMsg = true;
      this.disableUploadButton1 = true;
      this.disableRadioButtonUpdate1 = false;
    });
  }

  selectSQLMode1(event: any) {
    if (event.target.checked == true) {
      this.selectedSqlMode1 = "update";
    } else {
      this.selectedSqlMode1 = "insert";
    }
  }

  generateInitialScript01() {
    this.sqlGeneratorService.generateInitialScript1(this.selectedSqlMode1).subscribe(res => {
      this.sqlScript = res;
      this.showSuccessMsg = false;
      this.disableRadioButtonUpdate1 = true;
      this.disableGenerateButton1 = true;
      this.inputFile1.nativeElement.value = '';
      this.selectedSqlMode1 = "insert";
      this.sqlModeUpdate1.nativeElement.checked = false;
    }, (err) => {
      this.errorMessage = err.message;
    });
  }

  selectInitialFileJson02(inputFile: any, event: any) {
    this.initialFileJson02 = event.target.files[0];
    this.showSuccessMsg2 = false;
    if (this.initialFileJson02.type == 'application/json') {
      this.disableUploadButton2 = false;
    } else {
      Swal.fire("You can select only JSON file");
      inputFile.value = '';
    }
  }

  uploadInitialFileJson02() {
    this.disableGenerateButton2 = false;
    this.errorMessage2 = '';
    this.sqlGeneratorService.uploadInitialFileJson2(this.initialFileJson02).subscribe(res => {
      this.showSuccessMsg2 = true;
      this.disableUploadButton2 = true;
      this.disableRadioButtonUpdate2 = false;
    });
  }

  selectSQLMode2(event: any) {
    if (event.target.checked == true) {
      this.selectedSqlMode2 = "update";
    } else {
      this.selectedSqlMode2 = "insert";
    }
  }

  generateInitialScript02() {
    this.sqlGeneratorService.generateInitialScript2(this.selectedSqlMode2).subscribe(res => {
      this.sqlScript = res;
      this.showSuccessMsg2 = false;
      this.disableRadioButtonUpdate2 = true;
      this.disableGenerateButton2 = true;
      this.inputFile2.nativeElement.value = '';
      this.selectedSqlMode2 = "insert";
      this.sqlModeUpdate2.nativeElement.checked = false;
    }, (err) => {
      this.errorMessage2 = err.message;
    });
  }
}
