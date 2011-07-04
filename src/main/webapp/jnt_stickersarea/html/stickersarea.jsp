<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<%--If we are in preview mode, we display stickers and the form to create a new sticker--%>
<c:if test="${renderContext.previewMode || renderContext.contributionMode}">

    <%--We load resources @Todo : replace by a simple addRessources--%>
    <template:addResources type="javascript" resources="jquery.min.js,jquery-ui.min.js,jquery.fancybox.js,stickers.js"/>
    <template:addResources type="css" resources="jquery.fancybox.css,stickers.css" />

    <%--We define the path of the currentPage--%>
    <c:set var="currentPagePath" value="${renderContext.mainResource.node.path}" scope="request"/>

    <%--We build the full path--%>
    <c:set var="fullPath" value="${currentPagePath}/stickers" scope="request" />

    <%--We include the sticker creation form--%>
    <template:include view="addsticker" />


    <div id="main">

        <%--We retrieve stickers corresponding to the current page--%>
        <jcr:sql var="stickers" sql="select * from [jnt:sticker] as stickers where ISDESCENDANTNODE(stickers,'${fullPath}')"/>

        <c:forEach items="${stickers.nodes}" var="sticker"  >
             <template:module node="${sticker}" editable="false"/>
        </c:forEach>

    </div>

     <script type="text/javascript">

            $('div.bodywrapper').append($('#main').html());

    </script>

</c:if>


<c:if test="${renderContext.editModeConfigName eq 'studiomode'}">
    JahiApps : Stickers
</c:if>