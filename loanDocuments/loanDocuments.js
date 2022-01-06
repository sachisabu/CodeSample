import {LightningElement, api, wire, track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import {getRecord, updateRecord } from "lightning/uiRecordApi";
import { refreshApex } from '@salesforce/apex';
import getApplicationDocuments from '@salesforce/apex/LoanDocumentController.getLoanDocumentCallout';
import LOAN_ID from '@salesforce/schema/Loan__c.Loan_ID__c';
import BRAND_ID from '@salesforce/schema/Loan__c.Brandid__c';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

const columns = [
    {label: 'Document Name', type: 'button', wrapText: true, hideDefaultActions: true, typeAttributes: {label: { fieldName: 'description' },
            alternativeText:'Click to open in new tab', name: 'showDoc', variant: 'base'}},
    {label: 'Create Date', fieldName: 'date', type: 'dateTime', hideDefaultActions: true}
];

export default class ApplicationDocuments extends NavigationMixin(LightningElement) {
    @api recordId;
    _showSpinner = true;
    columns = columns;
    data;
    isShow = false;
    @track applicationId;
    @track brandid;
    wireData;
    DocumentsMessage;


    @wire(getRecord, {recordId: '$recordId', fields: [LOAN_ID,BRAND_ID]})
    application(result) {
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'A data sync error has occurred. Please contact your system administrator.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.wireData = result;
        if(result.data) {
            this.applicationId = result.data.fields.Loan_ID__c.value;
            this.brandid = result.data.fields.Brandid__c.value;
            getApplicationDocuments({applicationId : result.data.fields.Loan_ID__c.value, brandid:result.data.fields.Brandid__c.value, sourceForEndpoint: 'documents', documentId: ''})
                .then(response => {
                    this.showSpinner = true;
                    this.isShow = true;
                    this.data = JSON.parse(response).documents;
                    //this.data = response;
                    console.log('DAATAAA:::'+this.data);
                    console.log('response:::'+response);
                    if(this.data == null) {
                        this.DocumentsMessage = 'No documents found.';
                    }
                    this.data.forEach(function (item) {
                        item.date = new Date(item.date).toLocaleString();
                    });
                    this.showSpinner = false;
                }).catch(error => {
                this.isShow = false;
                if(this.DocumentsMessage == null) {
                    this.dispatchEvent(event);
                    this.DocumentsMessage = 'A data sync error has occurred. Please contact your system administrator.';
                }
                console.log('Error: ' + result.error);
                console.log(error);
                this.showSpinner = false;
            });
        }
        else if(result.error) {
            this.showSpinner = false;
            this.noDocumentsMessage = 'No documents found.';
            this.isShow = false;
        }
    };

    get showSpinner() {
        return this._showSpinner;
    }

    set showSpinner(value) {
        this._showSpinner = value;
    }
    handleGetDocument(event) {
        if(event.detail.action.name === 'showDoc') {
            let row = event.detail.row;
                    this[NavigationMixin.GenerateUrl]({
                        type: 'standard__webPage',
                        attributes: {
                            url: '/apex/showLoanDocument?loanid='+this.applicationId+'&brandid='+this.brandid+'&documentid='+row.id+'&title='+row.description
                        }
                    }).then(generatedUrl => {
                        window.open(generatedUrl,'_self');
                    });
        }
    }
}