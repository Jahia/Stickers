<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sticker ${currentNode.properties.color.string}" style="left:${currentNode.properties.left.string}px;top:${currentNode.properties.top.string}px;	z-index:${currentNode.properties.zindex.long}">
		<div class="body">${currentNode.properties.text.string}</div>
		<div class="author">${currentNode.properties['jcr:createdBy'].string}</div>
        <c:if test="${currentNode.properties['jcr:createdBy'].string eq renderContext.user.username}"><div class="delete"><a href="" id="${currentNode.properties['j:nodename'].string}" class="delete"></a></div></c:if>
		<span class="data">${currentNode.properties['j:nodename'].string}</span>
</div>