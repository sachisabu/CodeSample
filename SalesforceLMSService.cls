/* *************************************************************************************************************
        
      Date             Author              Story No                  Description
      -------------    -------------      -------------           ------------------------------  
	   25-08-2021       sadashiv            571015                  created class for calling API 
       07-12-2021       udit               618909                  created method for calling repay API 

	Test class :- SalesforceLMSServiceTest
  
    ************************************************************************************************************** */
public class SalesforceLMSService {
    
    public static LMS_Service__mdt LMS_Service = [ SELECT Id, Api_Version__c, Ocp_Apim_Subscription_key__c, Content_Type__c 
                                                  FROM LMS_Service__mdt 
                                                  LIMIT 1 ];
    
     @TestVisible
    public static HTTPResponse getHttpRequestEXPR(String url) {        
        try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url  '+url);           
            request.setEndpoint(url);
            request.setTimeout(20000);
            request.setMethod('GET');
            request.setheader('Api-Version',LMS_Service.Api_Version__c);                    
            request.setheader('Ocp-Apim-Subscription-Key',LMS_Service.Ocp_Apim_Subscription_key__c);     
            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }
   
     @TestVisible
    public static HTTPResponse deleteHttpRequestEXPR(String url) {
         try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url  '+url);           
            request.setEndpoint(url);
            request.setMethod('DELETE');
            request.setheader('Api-Version',LMS_Service.Api_Version__c);                    
            request.setheader('Ocp-Apim-Subscription-Key',LMS_Service.Ocp_Apim_Subscription_key__c);             
            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }

    @TestVisible
    public static HTTPResponse getHttpRequestPatchEXPR(String url,string strBody) {        
        try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url new   '+url);           
            request.setEndpoint(url);
            request.setMethod('PATCH');
            request.setheader('Api-Version',LMS_Service.Api_Version__c);                    
            request.setheader('Ocp-Apim-Subscription-Key',LMS_Service.Ocp_Apim_Subscription_key__c);
            request.setHeader('Content-Type', LMS_Service.Content_Type__c);
            request.setHeader('Accept', LMS_Service.Content_Type__c);
            request.setBody(strBody);     
            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }

    @TestVisible
    public static HTTPResponse getHttpRequestPOSTEXPR(String url,string strBody) {        
        try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url new   '+url);           
            request.setEndpoint(url);
            request.setMethod('POST');
            request.setheader('Api-Version',LMS_Service.Api_Version__c);                    
            request.setheader('Ocp-Apim-Subscription-Key',LMS_Service.Ocp_Apim_Subscription_key__c);
            request.setHeader('Content-Type', LMS_Service.Content_Type__c);
            request.setHeader('Accept', LMS_Service.Content_Type__c);
            request.setBody(strBody);     
            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }

    /**************** FOR REPAY API *************************/
    @TestVisible
    public static HTTPResponse getHttpRequestPOSTRepay(String appToken, String url,string strBody) {        
        try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url new   '+url); 

            request.setheader('Authorization','apptoken '+appToken);
            request.setHeader('Content-Type', 'application/json');
            request.setEndpoint(url);
            request.setMethod('POST');
            request.setBody(strBody);

            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }

    @TestVisible
    public static HTTPResponse getHttpRequestPOSTCutoff(String url,string strBody) {        
        try{
            final HttpRequest request = new HttpRequest();
            final HTTPResponse responseEntity;
            system.debug('url new   '+url);           
            request.setEndpoint(url);
            request.setMethod('POST');
            request.setheader('Api-Version',LMS_Service.Api_Version__c);                    
            request.setheader('Ocp-Apim-Subscription-Key',LMS_Service.Ocp_Apim_Subscription_key__c);
            request.setHeader('Content-Type', LMS_Service.Content_Type__c);
            request.setBody(strBody);     
            responseEntity = new Http().send(request);          
            System.debug('responseEntity:'+responseEntity);
            System.debug('Response: ' + responseEntity.getBody());          
            return responseEntity;
        }
        catch(Exception e){
            ApexLogUtility.createApexLogExceptionRecord(e.getTypeName(), e.getMessage(), string.valueOf(e.getLineNumber()), true,'', '', '');
            system.debug('Exception is-->'+e.getmessage()+' at line number-->'+e.getlineNumber()); 
        }     
        return null;
    }

}