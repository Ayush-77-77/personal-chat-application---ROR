// app/javascript/controllers/chat_subscription_controller.js
import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
// Connects to data-controller="chat-subscription"
export default class extends Controller {
  // Define static values for the controller
  static values = { chatId: Number, currentUserId: Number }
  static targets = ["chats"]
  connect() {
    // Create a WebSocket channel for ChatChannel with specified chat_id
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      // Define a callback for processing received data
      { received: data => this.insertMessage(data) }
    )
    console.log(`Subscribed to chat ${this.chatIdValue}`);
  }
  resetForm(event) {
    event.target.reset()
  }
  // Function to insert a new message into the DOM
  insertMessage(data) {
    // Lets check if the current user is the sender of the message
    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    // Build the HTML element for the new message
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message)
    // Insert the message element into the messages target
    this.chatsTarget.insertAdjacentHTML("beforeend", messageElement);
    // Scroll to the bottom of the messages container to show the latest message
    this.chatsTarget.scrollTo(0, this.chatsTarget.scrollHeight);
    document.querySelector("#message_content").value = ""
  }
  // Function to build the HTML element for a message
  buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.justifyClass(currentUserIsSender)}">
        <div class="${this.userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  // Functions to determine the justification and styling class based on sender

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }
  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
}

// In your CSS file, customize the styling for sender and receiver messages.