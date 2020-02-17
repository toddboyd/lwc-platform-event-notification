public with sharing class ClientNotification {
    public static void SendNotification(String application, String message, ClientNotificationType notificationType) {
        ClientNotification__e clientNotification = new ClientNotification__e();
        clientNotification.Application__c = application;
        clientNotification.User__c = UserInfo.getUserId();
        clientNotification.Message__c = message;
        clientNotification.Type__c = getNotificationtype(notificationType);
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

