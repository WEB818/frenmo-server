# Frenmo

#### Team: Jack Pupel, Wendy Bartos, Angel Alicea, Javier Zapien, Dana Zinatbakhsh

#### Live Demo: https://frenmo-client.vercel.app/

#### Demo Credentials

Username: WEB818<br/>
Password: Password1!

---

## Summary

Frenmo is a site where users can send or request favors from their community and their friends.

---

## Technologies used

Front-End: _ReactJS | Sass/Scss_

Back-End: _Node.js | Knex.js | Express.js | PostgreSQL_

Testing: _Mocha | Chai_

---

## API

### Requests

The Frenmo API is based on REST principles.

| Method | Action                                           |
| ------ | ------------------------------------------------ |
| GET    | Retrieves resources                              |
| POST   | Creates resources                                |
| PUT    | Changes and/or replaces resources or collections |
| PATCH  | Changes and/or replaces resources or collections |
| DELETE | Deletes resources                                |

### Response Status Codes

Web API uses the following response status codes.

| STATUS CODE | DESCRIPTION                                                                                                                                                          |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 200         | OK - The request has succeeded. The client can read the result of the request in the body and the headers of the response.                                           |
| 201         | Created - The request has been fulfilled and resulted in a new resource being created.                                                                               |
| 204         | No Content - The request has succeeded but returns no message body.                                                                                                  |
| 400         | Bad Request - The request could not be understood by the server due to malformed syntax. The message body will contain more information.                             |
| 401         | Unauthorized - The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials. |
| 403         | Forbidden - The server understood the request, but is refusing to fulfill it.                                                                                        |
| 404         | Not Found - The requested resource could not be found. This error can be due to a temporary or permanent condition.                                                  |
| 500         | Internal Server Error.                                                                                                                                               |

## Users

---

| METHOD | ENDPOINT         | USAGE                                                                                                                           | RETURNS                                                                                                        |
| ------ | ---------------- | ------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| POST   | /api/user        | Creates a new user. Returns json with the user's name and username. Requires username, name, password in request body.          | { "id": 100, "name": "Jane", "username": "Jane123" }                                                           |
| GET    | /api/user        | Get all users. Returns an array of users with id, name, and username                                                            | [ { "id": 100, "name": "Jane", "username": "Jane123" }, { "id": 101, "name": "Jane", "username": "Jane456" } ] |
| GET    | /api/user/{id}   | Get user by id. Returns username, name, description, phone #)                                                                   | { "username": "Jane123", "name": "Jane", "description": "", "phone": "999-999-9999" }                          |
| POST   | /api/user/search | Requires username in request body. Returns a list of strings with a limit of 10 with usernames that start with the input string | [ { "id": 100, "name": "Jane", "username": "Jane123" }, { "id": 101, "name": "Jane", "username": "Jane456" } ] |

### Request Parameters

| Path Parameters | Value       |
| --------------- | ----------- |
| id              | The user id |

<br/>

| Header Field  | Value                                                                                                                            |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Authorization | _Required_ Bearer Token                                                                                                          |
| Content-Type  | Required if parameters are passed in the request body, otherwise ignored. The content type of the request body: application/json |

<br/>

| Request Body Data | Value  |
| ----------------- | ------ |
| username          | string |
| name              | string |
| password          | string |
| phone number      | string |
| description       | string |

## Friends

---

| METHOD | ENDPOINT                | USAGE                                                                                                                                                                                                                           | RETURNS                                                                                                                                                                                                                              |
| ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GET    | /api/friend             | Gets a list of friends for authorized user. Returns id, fav_accepted, fav_requested, username, name, description                                                                                                                | [ {"id": 83, "fav_accepted": 0, "fav_requested": 0, "username": "Bart", "name": "Wendy Bartos", "description": "" }, { "id": 84, "fav_accepted": 0, "fav_requested": 0, "username": "WEB818", "name": "Guest", "description": "" } ] |
| POST   | /api/friend             | Requires friend_id in request body. Makes an association with the authorized user and with the user in the request body.                                                                                                        | {"user_id": 13, "friend_id": 12, "accepted": true }                                                                                                                                                                                  |
| PATCH  | /api/friend/{friend_id} | Changes the accepted parameter to true. Should only be used in the case of accepting a request to be friends. Should not be able to patch accepted parameter to false. Attempting to patch accepted as false will return a 401. |
| DELETE | /api/friend/{friend_id} | Deletes the friendship. Should be used in the event of declining a request for friendship                                                                                                                                       |

### Request Parameters

| Path Parameters | Value                 |
| --------------- | --------------------- |
| friend_id       | The user id of friend |

<br/>

| Header Field  | Value                                                                                                                            |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Authorization | _Required_ Bearer Token                                                                                                          |
| Content-Type  | Required if parameters are passed in the request body, otherwise ignored. The content type of the request body: application/json |

<br/>

| Request Body Data | Value   |
| ----------------- | ------- |
| friend_id         | integer |

## Favors

---

| METHOD | ENDPOINT                     | USAGE                                                                                                                                                                                                                                                                                                                                                                                                                    | RETURNS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------ | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GET    | /api/favor/{id}              | Will return an object with the favor indicated by id.                                                                                                                                                                                                                                                                                                                                                                    | Returns 401 if favor does not exist. Returns 403 if the user does not have access to favor. If authorized and favor exists, returns 200 and an object containing: favor_id, favor title, favor description, category, favor expiration_date, favor publicity, favor user_location, favor tags, favor limit, outstanding id, outstanding receiver_redeemed, oustanding giver_redeemed as issuer_redeemed, creator id,creator name, creator username, issuer id, issuer name, issuer username, receiver id, receiver name, receiver username |
| GET    | /api/favor/friend            | Gets favors that were posted among your friends and not the general public                                                                                                                                                                                                                                                                                                                                               | Returns 200 and an array of objects, each containing: favor_id, favor title, favor description, category, favor expiration_date, favor publicity, favor user_location, favor tags, favor limit, outstanding id, outstanding receiver_redeemed, oustanding giver_redeemed as issuer_redeemed, creator id, creator name, creator username, issuer id, issuer name, issuer username, receiver id, receiver name, receiver username                                                                                                            |
| GET    | /api/favor                   | Gets a list of favors from the local community. Does not show private or friend favors                                                                                                                                                                                                                                                                                                                                   | Returns 200 and an array of objects, each containing: favor_id, favor title, favor description, category, favor expiration_date, favor publicity, favor user_location, favor tags, favor limit, outstanding id, outstanding receiver_redeemed, oustanding giver_redeemed as issuer_redeemed, creator id, creator name, creator username, issuer id, issuer name, issuer username, receiver id, receiver name, receiver username                                                                                                            |
| GET    | /api/favor/personal          | Gets favors that were posted directly to you                                                                                                                                                                                                                                                                                                                                                                             | Returns 200 and an array of objects, each containing: favor_id, favor title, favor description, category, favor expiration_date, favor publicity, favor user_location, favor tags, favor limit, outstanding id, outstanding receiver_redeemed, oustanding giver_redeemed as issuer_redeemed, creator id, creator name, creator username, issuer id, issuer name, issuer username, receiver id, receiver name, receiver username                                                                                                            |
| PATCH  | /api/favor/{id}              | Allowed: patching of certain fields under certain conditions, increasing the expiration date of a favor that has receiver_id set, updating any field if favor_outstanding does not reference its id                                                                                                                                                                                                                      | Returns 400 if request is not allowed. Takes expiration_date, tags, category, user_location, limit in the request body. Returns 204 on success                                                                                                                                                                                                                                                                                                                                                                                             |
| POST   | api/favor/issue              | This method should be used to update the giver and receiver of a favor in favor_outstanding. If a favor is not outstanding and giver and receiver id is in the body, then it will add a row for it in favor_outstanding. The limit of that favor to be issued will stop the patch if there is an attempt to go over. An error will be thrown in this case. Takes in favor_id, users_id, reciever_id in the request body. | Returns 204 and the updated outstanding favor on resolution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| PATCH  | /api/favor/redeem/{favor_id} | Takes favor id as a parameter. Takes outstanding_id in the request body and should redeem or confirm redeeming of a favor for the authorized user                                                                                                                                                                                                                                                                        | Returns 404 if the favor does not exist. Returns 403 if the favor is already redeemed, or if the user is unrelated to the transaction. Returns 204 on success                                                                                                                                                                                                                                                                                                                                                                              |
| DELETE | /api/favor/{id}              | Deletes a favor. Takes id as a parameter                                                                                                                                                                                                                                                                                                                                                                                 | Returns 204 in response                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| POST   | /api/favor                   | Authorized post posts with the user as a creator of the favor but makes a null outstanding. Makes 1 outstanding favor with a value for the giver and receiver as null. Takes title, description as required parts of the body                                                                                                                                                                                            | Returns 400 if those aren't present.Tags, category, expiration date, publicity, user location and limit are optional body parameters. Returns 201 and the outstanding favor on success                                                                                                                                                                                                                                                                                                                                                     |
| GET    | /api/favor/public            | Gets favors that were posted to the general public                                                                                                                                                                                                                                                                                                                                                                       | Returns 200 and an array of objects, each containing: favor_id, favor title, favor description, category, favor expiration_date, favor publicity, favor user_location, favor tags,favor limit, outstanding id, outstanding receiver_redeemed, oustanding giver_redeemed as issuer_redeemed, creator id, creator name, creator username, issuer id, issuer name, issuer username, receiver id, receiver name, receiver username                                                                                                             |
| GET    | /api/favor/count/{id}        | Gets the number of times you can make an oustanding favor from a favor with the input id                                                                                                                                                                                                                                                                                                                                 | Returns json object with {remaining: number}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

## See More

[Frenmo Live App](https://frenmo-client.vercel.app/ "Demo - see credentials above")

[Frenmo Client (GitHub)](https://github.com/WEB818/frenmo-client "GitHub - client link")

[Frenmo Live Server](https://calm-wave-63861.herokuapp.com/ "Deployed server")
