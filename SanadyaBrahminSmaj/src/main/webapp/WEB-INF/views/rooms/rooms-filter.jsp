<form id="roomFilterForm" class="card p-3 shadow-sm mb-4">

  <div class="row g-3">

    <div class="col-md-3">
      <label>रूम प्रकार</label>
	  <select name="roomType" class="form-select">
	      <option value="">सभी</option>
	      <option value="ONLY_ROOM">केवल कमरा</option>
	      <option value="HALL">हॉल</option>
	      <option value="COMPLETE_FLOOR">पूरा फ्लोर</option>
		  <option value="COMPLETE_BUILDING">सामुदायिक भवन</option>  
	  </select>

    </div>

    <div class="col-md-2">
      <label>वयस्क</label>
      <select name="adults" class="form-select">
        <option value="">कोई भी</option>
        <c:forEach begin="1" end="6" var="i">
          <option value="${i}">${i}+</option>
        </c:forEach>
      </select>
    </div>

    <div class="col-md-2">
      <label>बच्चे</label>
      <select name="children" class="form-select">
        <option value="">कोई भी</option>
        <c:forEach begin="0" end="4" var="i">
          <option value="${i}">${i}+</option>
        </c:forEach>
      </select>
    </div>

  </div>

</form>
