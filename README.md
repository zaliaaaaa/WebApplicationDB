# WebApplicationDB

## **Project Overview**
WebApplicationDB is a basic social media web application built using **Java EE 8**, **Maven**, and **MySQL**. This project follows the MVC architecture and allows users to create posts, follow/unfollow users, and manage their social feed. The application is inspired by platforms like Facebook and X but follows a minimalistic approach.

## **Features**
### **User Functionality**
- Users can **create and delete** posts (limited to **five latest posts**).
- Users can **follow up to three other users**.
- Users can **unfollow** any followed user.
- The **landing page** displays posts from followed users (latest post only).
- If a followed user has **no posts**, they do not appear in the feed.

### **Admin Functionality**
- Admins can **create, delete, and update** user accounts.
- Admins have a **separate landing page** with user management tools.
- Admins can **view the last five messages** sent via the Help page.
- Super Admins can **manage admin accounts** in addition to regular users.

### **Pages & Navigation**
- **`login.jsp`** → User login page.
- **`signup.jsp`** → User registration page.
- **`landing.jsp`** → Displays posts from followed users.
- **`profile.jsp`** → Shows the user’s five latest posts.
- **`users.jsp`** → Allows users to follow/unfollow others.
- **`help.jsp`** → Enables users to send messages to admins.
- **`admin.jsp`** → Admin dashboard for user management.
- **`create.jsp`** → Allows admins to create new users.
- **`update.jsp`** → Bulk edit user details.
- **`delete.jsp`** → Bulk delete users.
- **`result.jsp`** → Displays changes after user modifications.

## **Database Structure**
### **Tables:**
1. **`account`** (user_name, password, user_role)
2. **`posts`** (user_name, post1, post2, post3, post4, post5)
3. **`follows`** (user_name, follow1, follow2, follow3)

### **Business Logic Constraints:**
- Users can create up to **five posts** (oldest post gets deleted upon the sixth post).
- Users can **follow up to three** other users.
- Users **cannot follow non-existent users**.
- The landing page only shows posts from **followed users with posts**.
- Error handling ensures that **no raw exceptions** are visible to users.

## **Technical Specifications**
- **Backend:** Java EE 8 (Servlets & JSP)
- **Frontend:** HTML, CSS (Minimalistic design inspired by Google Apps)
- **Database:** MySQL
- **Build System:** Maven
- **Server:** GlassFish
- **JDK Version:** Java 8

## **Setup & Deployment**
### **Prerequisites:**
1. **Install JDK 8** (Ensure Java is correctly configured).
2. **Install Apache NetBeans** (or any compatible Java IDE).
3. **Install MySQL** and create the required database tables.
4. **Set up GlassFish Server** and deploy the application.

### **Running the Project:**
1. Clone this repository:
   ```bash
   git clone https://github.com/zaliaaaaa/WebApplicationDB.git
   ```
2. Open **NetBeans** and import the Maven project.
3. Ensure GlassFish is running and connected.
4. Configure MySQL credentials in `web.xml`.
5. Deploy the project on GlassFish.
6. Access the application via `http://localhost:8080/WebApplicationDB`.

## **Issues & Debugging**
- **Error loading posts?** Ensure the `posts` table has data.
- **Error loading followed users?** Verify the `follows` table has valid entries.
- **Session not working?** Check if session attributes are correctly retrieved (`session.getAttribute("username")`).
- **GlassFish memory leak warning?** Restart the server and clear cached deployments.

## **Future Enhancements**
- Implement AJAX for seamless UI updates.
- Improve UI design for a modern social media experience.
- Add user profile pictures and bio sections.
- Enhance security with password hashing.

---
### **Author:** Jaz Mare C. Maglalang
**Course:** Applications Development and Emerging Technologies 1 (Web-Front-End)
**Section:** 2CSE

