
const notificationBar = document.querySelector('#notification');
const showBtn = document.querySelector("#show");
const counter = document.querySelector('#counter');

let currentNotifications=[];
let notifyCounter = 0;

showBtn.addEventListener('click',()=>{
    notificationBar.classList.toggle('hidden') ;
    
    if(notifyCounter > 0) {
        notifyCounter = 0 ; 
        counter.innerHTML = notifyCounter;
        markAsRead();
    }
})

const joinRequest = (id)=>{
    window
    .fetch(`http://localhost:3000/users/4/orders/${id}/join`,{
        method: 'put',
    })
    .then(res=>res.json())
    .then(res=>console.log(res))
    .catch(err=>console.log(err))
}
// get All notifications 
async function getAllNotifications() {

    const response = await fetch("http://localhost:3000/users/4/allnotifications");
    const {notifications} = await response.json();
    console.log(notifications);
    currentNotifications = notifications;
    handleViewNotification();
    
    // document.querySelector("#message").value = message;
}
document.onloadend = getAllNotifications() ;
//get new notications
async function getNewNotifications() {
    
    const response = await fetch("http://localhost:3000/users/4/notifications");
    const {notifications} = await response.json();
    console.log(notifications);
    if(notifications.length){
        currentNotifications = [...notifications,...currentNotifications];
        handleViewNotification();
    }
    // document.querySelector("#message").value = message;
    
}
// getNewNotifications();
setInterval(getNewNotifications , 3000);
// mark new notications as read
async function markAsRead() {

    const response = await fetch("http://localhost:3000/users/4/markasread");
    const res = await response.json();
    console.log(res);
    // document.querySelector("#message").value = message;
}
//array of notifications
function handleViewNotification(){
    notificationBar.innerHTML = currentNotifications.map(notification=>{
        
        switch(notification.action) {
            case 'invite' :
                const el= document.createElement('p');
                el.innerHTML = `<strong>${notification.sender}</strong> invited you to ${notification.notifiable_type}
                 <button>click To Join</button>`;
                 el.addEventListener('click',()=>{
                     joinRequest(notification.notifiable_id)
                    })
                 return el;
            break;
            case "joined" :
            return `<a href="#to_order_page_of${notification.notifiable_id}" > <p> <strong>${notification.sender}</strong> Joined Your ${notification.notifiable_type}</p> click To Show Order</a>`
        }
    })
    
    counter.innerHTML = notifyCounter = currentNotifications.reduce((acc, current) => {
       return acc + !current.read ;
    },0);  
}