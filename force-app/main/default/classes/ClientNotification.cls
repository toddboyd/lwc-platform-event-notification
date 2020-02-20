public with sharing class ClientNotification {
    public static void SendNotification(String application, String title, String message, ClientNotificationType notificationType, Boolean allUsers) {
        ClientNotification__e clientNotification = new ClientNotification__e();
        clientNotification.Application__c = application;
        clientNotification.Title__c = title;        
        clientNotification.Message__c = message;
        clientNotification.Type__c = getNotificationtype(notificationType);
        if (!allUsers) {
            clientNotification.User__c = UserInfo.getUserId();
        }
        Eventbus.publish(clientNotification);
    }   

    private static String getNotificationtype(ClientNotificationType notificationType) {
        switch on (notificationType) {
            when ERROR {
                return 'error';
            } 
            when SUCCESS {
                return 'success';
            } 
            when WARNING {
                return 'warning';
            }
            when else {
                return 'info'    ;
            }
        }
    }
}

