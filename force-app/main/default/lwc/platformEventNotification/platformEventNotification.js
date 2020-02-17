import { LightningElement, track, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { subscribe, unsubscribe } from "lightning/empApi";

export default class PlatformEventNotification extends LightningElement {
  @track channelName = "/event/ClientNotification__e";
  @api applicationName;
  subscription = {};

  showToast(title, message, variant) {
    const evt = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(evt);
  }

  connectedCallback() {
    const messageCallback = function(response) {
      const message = response.data.payload;
      this.showToast(
        message.Application__c,
        message.Message__c,
        message.Type__c
      );
    }.bind(this);
    subscribe(this.channelName, -1, messageCallback).then(response => {
      this.subscription = response;
    });
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
  }
}
