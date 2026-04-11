<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${realm.displayName!}</title>

<style>
        @font-face {
            font-family: "Soho";
            font-display: swap;
            src: url("fonts/soho-medium.woff2") format("woff2");
        }

        @font-face {
            font-family: "Akko";
            font-display: swap;
            src: url("fonts/akko-regular.woff2") format("woff2");
        }

        body{
            background-color:purple;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            display: grid;
            place-items: center;
        }

        .title{
            font: normal 40px/48px soho;
            color: white;
        }

        button{
            background-color: purple;
            border: 1px solid white;
            border-radius: 8px;
            font: normal 14px/16px akko;
            color: white;
            height: 40px;
            padding: 0 40px;
            cursor: pointer;
        }

        button:hover{
            opacity: 0.5;
        }

        button:active{
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <h1>Octopus 2 login</h1>

    <#if message?has_content>
        <div style="color:red;">
            ${message.summary}
        </div>
    </#if>

    <form id="kc-form-login" action="${url.loginAction}" method="post">
        <div>
            <label for="username">Username</label>
            <input id="username" name="username" type="text" autofocus />
        </div>

        <div>
            <label for="password">Password</label>
            <input id="password" name="password" type="password" />
        </div>

        <div>
            <input type="submit" value="Log in" />
        </div>
    </form>
</body>
</html>