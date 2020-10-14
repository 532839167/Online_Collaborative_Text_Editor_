<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Collaborative Editor</title>

    <script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.10.1/ckeditor.js"></script>
    <style type="text/css">
        /* Minimal styling to center the editor in this sample */
        body {
            padding: 30px;
            display: flex;
            align-items: center;
            text-align: center;
        }

        p {
            text-align: right;
        }

        .container {
            margin: 0 auto;
        }
    </style>

    <script>

        // upon enter this page, get data from backend
        $(document).ready(function () {
            var editor = initeditor();
	        // get content from sessionStorage
            var initcontent = window.sessionStorage.getItem("comment_top");
            // initial page value
            initdata(editor, initcontent);
            // trigger auto saving to sessionStorage when change occur
            editor.on('change', function (evt) {
                window.sessionStorage.setItem("comment_top", evt.editor.getData());
            });
        });

        function initeditor() {
            var editor = CKEDITOR.replace('editor1', {
                toolbar: [
                    {name: 'clipboard', items: ['Undo', 'Redo']},
                    {name: 'styles', items: ['Format', 'Font', 'FontSize']},
                    {
                        name: 'basicstyles',
                        items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting']
                    },
                    {name: 'colors', items: ['TextColor', 'BGColor']},
                    {name: 'align', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']},
                    {name: 'links', items: ['Link', 'Unlink']},
                    {
                        name: 'paragraph',
                        items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
                    },
                    {name: 'insert', items: ['Image', 'Table']},
                    {name: 'tools', items: ['Maximize']},
                    {name: 'editing', items: ['Scayt']}
                ],

                height: 800,  //box height
                contentsCss: ['https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.10.1/contents.css'],
                allowedContent: true,
                disallowedContent: 'img{width,height,float}',
                extraAllowedContent: 'img[width,height,align]',
                extraPlugins: 'tableresize,uploadimage,uploadfile',
                bodyClass: 'document-editor',
                format_tags: 'p;h1;h2;h3;pre',
                removeDialogTabs: 'image:advanced;link:advanced'
            });
            return editor;
        };

        function initdata(editor, initcontent) {

            var aj = $.ajax({
                type: "POST",
                url: "initdata",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data == null) {
                        alert("No new information is found");
                    } else if (!initcontent && typeof initcontent != "undefined" && initcontent != 0) {
                        editor.setData(data.scontent);
                    } else {
                        editor.setData(initcontent);
                    }
                }
            });
        };

        //Manually save content
        function ManualSave() {
            var aj = $.ajax({
                url: 'save',   // redirect to action
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json;chartset=UTF-8',
                data: JSON.stringify(window.sessionStorage.getItem("comment_top")), //  传批量的参数 list
                success: function (data) {
                    if (data.state) {
                        alert("Success! ");
                        window.sessionStorage.removeItem("comment_top");
                        window.location.reload();
                    } else {
                        alert("Fail! ");
                    }
                },
                error: function () {
                    alert("Internet Connection Error");
                }
            });
        };

    </script>

</head>
<body>
<%-- 1 Editing Page --%>
<div class="container">
    <form method="post">
        <h2><label for="editor1">Weekly Report Editor</label></h2>
        <p><a href="javascript:void(0);" onclick="ManualSave();">Save</a></p>
        <textarea name="editor1" id="editor1"> </textarea>
    </form>
</div>
</body>
</html>