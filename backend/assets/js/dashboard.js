// =====================
// Dashboard Management
// =====================
// Tất cả logic JS dashboard, CRUD các module, được gom nhóm, tối ưu hóa, dễ bảo trì

// =====================
// Utils - Hàm dùng chung
// =====================
const $ = selector => document.querySelector(selector);
const $$ = selector => document.querySelectorAll(selector);

function setActiveMenu(page) {
    $$('.sidebar-menu li').forEach(item => {
        item.classList.remove('active');
        if (item.textContent.toLowerCase().includes(page)) {
            item.classList.add('active');
        }
    });
}

function showMessage(target, message, color = 'blue') {
    if (target) target.innerHTML = `<div style="color: ${color};">${message}</div>`;
}

function fetchData(url, options = {}) {
    return fetch(url, options).then(res => res.json());
}

function renderTable(headers, rowsHtml) {
    return `
        <table>
            <thead><tr>${headers.map(h => `<th>${h}</th>`).join('')}</tr></thead>
            <tbody>${rowsHtml}</tbody>
        </table>
    `;
}

// =====================
// Dashboard
// =====================
function loadDashboard() {
    $('#mainContent').innerHTML = `
        <h2>Trang chủ</h2>
        <div class="card-container">
            <div class="card"><h3>Tổng doanh thu hôm nay</h3><div class="value">5,420,000 ₫</div><div>+12% so với hôm qua</div></div>
            <div class="card"><h3>Tổng đơn hàng</h3><div class="value">42</div><div>+5 đơn so với hôm qua</div></div>
            <div class="card"><h3>Khách hàng mới</h3><div class="value">8</div><div>Tổng: 245 khách hàng</div></div>
        </div>
        <h3>Đơn hàng mới nhất</h3>
        <table><thead><tr><th>Mã đơn</th><th>Thời gian</th><th>Khách hàng</th><th>Tổng tiền</th><th>Trạng thái</th><th>Thao tác</th></tr></thead><tbody>
            <tr><td>#10025</td><td>10:30 27/04/2025</td><td>Nguyễn Văn An</td><td>120,000 ₫</td><td>Đã giao</td><td><div class="action-buttons"><button class="btn btn-primary">Xem</button></div></td></tr>
            <tr><td>#10024</td><td>09:45 02/05/2025</td><td>Lê Vân Trang</td><td>85,000 ₫</td><td>Đang giao</td><td><div class="action-buttons"><button class="btn btn-primary">Xem</button></div></td></tr>
        </tbody></table>
    `;
    setActiveMenu('trang chủ');
}

// =====================
// Module Loader
// =====================
function loadContent(page) {
    switch (page) {
        case 'drinks': Drinks.render(); break;
        case 'employees': Employees.render(); break;
        case 'customers': Customers.render(); break;
        case 'ingredients': Ingredients.render(); break;
        case 'invoices': Invoices.render(); break;
        case 'orders': Orders.render(); break;
        default: loadDashboard(); break;
    }
    setActiveMenu(page);
}

// =====================
// Drinks Module
// =====================
const Drinks = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý thức uống</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Thêm thức uống mới</h3>
                <form id="drinkForm" style="display: grid; gap: 10px;">
                    <div><label>Tên thức uống:</label><input type="text" name="name" required></div>
                    <div><label>Loại:</label><select name="category" required><option value="Cà phê">Cà phê</option><option value="Trà">Trà</option><option value="Sinh tố">Sinh tố</option><option value="Nước ép">Nước ép</option></select></div>
                    <div><label>Size:</label><select name="size" required><option value="S">S</option><option value="M">M</option><option value="L">L</option></select></div>
                    <div><label>Giá:</label><input type="number" name="price" required></div>
                    <div><label>Trạng thái:</label><select name="status" required><option value="1">Còn bán</option><option value="0">Ngừng bán</option></select></div>
                    <button type="submit" class="btn btn-primary">Thêm thức uống</button>
                </form>
                <div id="formMessageDrink"></div>
            </div>
            <h3>Danh sách thức uống</h3>
            <div id="drinksTable"></div>
        `;
        this.loadList();
        $('#drinkForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessageDrink'), 'Đang xử lý...');
            fetchData('modules/drinks/drinks.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessageDrink'), 'Thêm thức uống thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessageDrink'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessageDrink'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/drinks/drinks.php')
            .then(result => {
                if (!result.success) throw new Error(result.message);
                const rows = result.data.map(drink => `
                    <tr>
                        <td>${drink.DrinkID}</td>
                        <td>${drink.Name}</td>
                        <td>${drink.Category}</td>
                        <td>${drink.Size}</td>
                        <td>${Number(drink.Price).toLocaleString('vi-VN')} ₫</td>
                        <td>${drink.Status == 1 ? 'Còn bán' : 'Ngừng bán'}</td>
                        <td><div class="action-buttons"><button class="btn btn-primary" onclick="Drinks.edit(${drink.DrinkID})">Sửa</button><button class="btn btn-danger" onclick="Drinks.delete(${drink.DrinkID})">Xóa</button></div></td>
                    </tr>
                `).join('');
                $('#drinksTable').innerHTML = renderTable(['ID','Tên thức uống','Loại','Size','Giá','Trạng thái','Thao tác'], rows);
            })
            .catch(() => alert('Có lỗi khi tải danh sách thức uống'));
    },
    edit(id) {
        fetchData(`modules/drinks/drinks.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const drink = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa thức uống</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editDrinkForm" style="display: grid; gap: 10px;">
                                <div><label>Tên thức uống:</label><input type="text" name="name" value="${drink.Name || ''}" required></div>
                                <div><label>Loại:</label><select name="category" required><option value="Cà phê" ${drink.Category==='Cà phê'?'selected':''}>Cà phê</option><option value="Trà" ${drink.Category==='Trà'?'selected':''}>Trà</option><option value="Sinh tố" ${drink.Category==='Sinh tố'?'selected':''}>Sinh tố</option><option value="Nước ép" ${drink.Category==='Nước ép'?'selected':''}>Nước ép</option></select></div>
                                <div><label>Size:</label><select name="size" required><option value="S" ${drink.Size==='S'?'selected':''}>S</option><option value="M" ${drink.Size==='M'?'selected':''}>M</option><option value="L" ${drink.Size==='L'?'selected':''}>L</option></select></div>
                                <div><label>Giá:</label><input type="number" name="price" value="${drink.Price || ''}" required></div>
                                <div><label>Trạng thái:</label><select name="status" required><option value="1" ${drink.Status==1?'selected':''}>Còn bán</option><option value="0" ${drink.Status==0?'selected':''}>Ngừng bán</option></select></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('drinks')">Hủy</button>
                            </form>
                            <div id="formMessageEditDrink"></div>
                        </div>
                    `;
                    $('#editDrinkForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditDrink'), 'Đang xử lý...');
                        fetchData('modules/drinks/drinks.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditDrink'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('drinks'), 1000);
                                } else showMessage($('#formMessageEditDrink'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditDrink'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu thức uống!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu thức uống!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa thức uống này?')) {
            fetchData(`modules/drinks/drinks.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa thức uống thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa thức uống'));
        }
    }
};

// =====================
// Employees Module
// =====================
const Employees = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý nhân viên</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Thêm nhân viên mới</h3>
                <form id="employeeForm" style="display: grid; gap: 10px;">
                    <div><label>Họ và tên:</label><input type="text" name="fullname" required></div>
                    <div><label>Giới tính:</label><select name="gender"><option value="Nam">Nam</option><option value="Nữ">Nữ</option><option value="Khác">Khác</option></select></div>
                    <div><label>Số điện thoại:</label><input type="tel" name="phone" required></div>
                    <div><label>Email:</label><input type="email" name="email"></div>
                    <div><label>Vị trí:</label><select name="position"><option value="Quản lý">Quản lý</option><option value="Thu ngân">Thu ngân</option><option value="Pha chế">Pha chế</option><option value="Phục vụ">Phục vụ</option><option value="Giao hàng">Giao hàng</option><option value="Bảo vệ">Bảo vệ</option><option value="Khác">Khác</option></select></div>
                    <div><label>Lương:</label><input type="number" name="salary" required></div>
                    <div><label>Ngày bắt đầu:</label><input type="date" name="startDate" required></div>
                    <div><label>Trạng thái:</label><select name="status"><option value="Đang làm">Đang làm</option><option value="Nghỉ việc">Nghỉ việc</option><option value="Tạm nghỉ">Tạm nghỉ</option></select></div>
                    <button type="submit" class="btn btn-primary">Thêm nhân viên</button>
                </form>
                <div id="formMessageEmployee"></div>
            </div>
            <h3>Danh sách nhân viên</h3>
            <div id="employeesTable"></div>
        `;
        this.loadList();
        $('#employeeForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessageEmployee'), 'Đang xử lý...');
            fetchData('modules/employees/employees.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessageEmployee'), 'Thêm nhân viên thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessageEmployee'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessageEmployee'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/employees/employees.php')
            .then(data => {
                if (data.success) {
                    const rows = data.data.map(emp => `
                        <tr>
                            <td>${emp.EmpID}</td>
                            <td>${emp.FullName}</td>
                            <td>${emp.Gender}</td>
                            <td>${emp.Phone}</td>
                            <td>${emp.Email || ''}</td>
                            <td>${emp.Position}</td>
                            <td>${Number(emp.Salary).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${emp.StartDate}</td>
                            <td>${emp.Status}</td>
                            <td><div class="action-buttons"><button class="btn btn-primary" onclick="Employees.edit(${emp.EmpID})">Sửa</button><button class="btn btn-danger" onclick="Employees.delete(${emp.EmpID})">Xóa</button></div></td>
                        </tr>
                    `).join('');
                    $('#employeesTable').innerHTML = renderTable(['ID','Họ và tên','Giới tính','SĐT','Email','Vị trí','Lương','Ngày bắt đầu','Trạng thái','Thao tác'], rows);
                }
            })
            .catch(() => alert('Có lỗi khi tải danh sách nhân viên'));
    },
    edit(id) {
        fetchData(`modules/employees/employees.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const emp = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa nhân viên</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editEmployeeForm" style="display: grid; gap: 10px;">
                                <div><label>Họ và tên:</label><input type="text" name="fullname" value="${emp.FullName || ''}" required></div>
                                <div><label>Giới tính:</label><select name="gender"><option value="Nam" ${emp.Gender==='Nam'?'selected':''}>Nam</option><option value="Nữ" ${emp.Gender==='Nữ'?'selected':''}>Nữ</option><option value="Khác" ${emp.Gender==='Khác'?'selected':''}>Khác</option></select></div>
                                <div><label>Số điện thoại:</label><input type="tel" name="phone" value="${emp.Phone || ''}" required></div>
                                <div><label>Email:</label><input type="email" name="email" value="${emp.Email || ''}"></div>
                                <div><label>Vị trí:</label><select name="position"><option value="Quản lý" ${emp.Position==='Quản lý'?'selected':''}>Quản lý</option><option value="Thu ngân" ${emp.Position==='Thu ngân'?'selected':''}>Thu ngân</option><option value="Pha chế" ${emp.Position==='Pha chế'?'selected':''}>Pha chế</option><option value="Phục vụ" ${emp.Position==='Phục vụ'?'selected':''}>Phục vụ</option><option value="Giao hàng" ${emp.Position==='Giao hàng'?'selected':''}>Giao hàng</option><option value="Bảo vệ" ${emp.Position==='Bảo vệ'?'selected':''}>Bảo vệ</option><option value="Khác" ${emp.Position==='Khác'?'selected':''}>Khác</option></select></div>
                                <div><label>Lương:</label><input type="number" name="salary" value="${emp.Salary || ''}" required></div>
                                <div><label>Ngày bắt đầu:</label><input type="date" name="startDate" value="${emp.StartDate || ''}" required></div>
                                <div><label>Trạng thái:</label><select name="status"><option value="Đang làm" ${emp.Status==='Đang làm'?'selected':''}>Đang làm</option><option value="Nghỉ việc" ${emp.Status==='Nghỉ việc'?'selected':''}>Nghỉ việc</option><option value="Tạm nghỉ" ${emp.Status==='Tạm nghỉ'?'selected':''}>Tạm nghỉ</option></select></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('employees')">Hủy</button>
                            </form>
                            <div id="formMessageEditEmployee"></div>
                        </div>
                    `;
                    $('#editEmployeeForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditEmployee'), 'Đang xử lý...');
                        fetchData('modules/employees/employees.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditEmployee'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('employees'), 1000);
                                } else showMessage($('#formMessageEditEmployee'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditEmployee'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu nhân viên!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu nhân viên!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa nhân viên này?')) {
            fetchData(`modules/employees/employees.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa nhân viên thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa nhân viên'));
        }
    }
};

// =====================
// Customers Module
// =====================
const Customers = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý khách hàng</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Thêm khách hàng mới</h3>
                <form id="customerForm" style="display: grid; gap: 10px;">
                    <div><label>Họ và tên:</label><input type="text" name="fullname" required></div>
                    <div><label>Số điện thoại:</label><input type="tel" name="phone" required></div>
                    <div><label>Email:</label><input type="email" name="email"></div>
                    <div><label>Giới tính:</label><select name="gender"><option value="Nam">Nam</option><option value="Nữ">Nữ</option><option value="Khác">Khác</option></select></div>
                    <div><label>Điểm:</label><input type="number" name="points" min="0" value="0"></div>
                    <div><label>Tổng chi tiêu (VNĐ):</label><input type="number" name="totalSpent" min="0" value="0"></div>
                    <button type="submit" class="btn btn-primary">Thêm khách hàng</button>
                </form>
                <div id="formMessage"></div>
            </div>
            <h3>Danh sách khách hàng</h3>
            <div id="customersTable"></div>
        `;
        this.loadList();
        $('#customerForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessage'), 'Đang xử lý...');
            fetchData('modules/customers/customers.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessage'), 'Thêm khách hàng thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessage'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessage'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/customers/customers.php')
            .then(data => {
                if (data.success) {
                    const rows = data.data.map(cus => `
                        <tr>
                            <td>${cus.CustomerID}</td>
                            <td>${cus.FullName}</td>
                            <td>${cus.Phone}</td>
                            <td>${cus.Email || ''}</td>
                            <td>${cus.Gender || ''}</td>
                            <td>${cus.Points || 0}</td>
                            <td>${(cus.TotalSpent || 0).toLocaleString('vi-VN')} VNĐ</td>
                            <td><div class="action-buttons"><button class="btn btn-primary" onclick="Customers.edit(${cus.CustomerID})">Sửa</button><button class="btn btn-danger" onclick="Customers.delete(${cus.CustomerID})">Xóa</button></div></td>
                        </tr>
                    `).join('');
                    $('#customersTable').innerHTML = renderTable(['ID','Họ và tên','SĐT','Email','Giới tính','Điểm','Tổng chi tiêu','Thao tác'], rows);
                }
            })
            .catch(() => alert('Có lỗi khi tải danh sách khách hàng'));
    },
    edit(id) {
        fetchData(`modules/customers/customers.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const cus = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa khách hàng</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editCustomerForm" style="display: grid; gap: 10px;">
                                <div><label>Họ và tên:</label><input type="text" name="fullname" value="${cus.FullName || ''}" required></div>
                                <div><label>Số điện thoại:</label><input type="tel" name="phone" value="${cus.Phone || ''}" required></div>
                                <div><label>Email:</label><input type="email" name="email" value="${cus.Email || ''}"></div>
                                <div><label>Giới tính:</label><select name="gender"><option value="Nam" ${cus.Gender==='Nam'?'selected':''}>Nam</option><option value="Nữ" ${cus.Gender==='Nữ'?'selected':''}>Nữ</option><option value="Khác" ${cus.Gender==='Khác'?'selected':''}>Khác</option></select></div>
                                <div><label>Điểm:</label><input type="number" name="points" value="${cus.Points || 0}" min="0"></div>
                                <div><label>Tổng chi tiêu (VNĐ):</label><input type="number" name="totalSpent" value="${cus.TotalSpent || 0}" min="0"></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('customers')">Hủy</button>
                            </form>
                            <div id="formMessageEditCustomer"></div>
                        </div>
                    `;
                    $('#editCustomerForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditCustomer'), 'Đang xử lý...');
                        fetchData('modules/customers/customers.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditCustomer'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('customers'), 1000);
                                } else showMessage($('#formMessageEditCustomer'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditCustomer'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu khách hàng!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu khách hàng!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa khách hàng này?')) {
            fetchData(`modules/customers/customers.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa khách hàng thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa khách hàng'));
        }
    }
};

// =====================
// Ingredients Module
// =====================
const Ingredients = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý nguyên liệu</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Thêm nguyên liệu mới</h3>
                <form id="ingredientForm" style="display: grid; gap: 10px;">
                    <div><label>Tên nguyên liệu:</label><input type="text" name="name" required></div>
                    <div><label>Đơn vị:</label><input type="text" name="unit" required></div>
                    <div><label>Số lượng:</label><input type="number" name="quantity" required></div>
                    <div><label>Giá nhập:</label><input type="number" name="price" required></div>
                    <div><label>Trạng thái:</label><select name="status"><option value="1">Còn hàng</option><option value="0">Hết hàng</option></select></div>
                    <div><label>Ghi chú:</label><textarea name="note"></textarea></div>
                    <button type="submit" class="btn btn-primary">Thêm nguyên liệu</button>
                </form>
                <div id="formMessageIngredient"></div>
            </div>
            <h3>Danh sách nguyên liệu</h3>
            <div id="ingredientsTable"></div>
        `;
        this.loadList();
        $('#ingredientForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessageIngredient'), 'Đang xử lý...');
            fetchData('modules/ingredients/ingredients.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessageIngredient'), 'Thêm nguyên liệu thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessageIngredient'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessageIngredient'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/ingredients/ingredients.php')
            .then(data => {
                if (data.success) {
                    const rows = data.data.map(ing => `
                        <tr>
                            <td>${ing.IngrID}</td>
                            <td>${ing.Name}</td>
                            <td>${ing.Unit}</td>
                            <td>${ing.StockQty}</td>
                            <td>${Number(ing.PricePerUnit).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${ing.Status == 1 || ing.Status == "1" ? 'Còn hàng' : (ing.Status == 0 || ing.Status == "0" ? 'Hết hàng' : '')}</td>
                            <td>${ing.Note || ''}</td>
                            <td><div class="action-buttons"><button class="btn btn-primary" onclick="Ingredients.edit(${ing.IngrID})">Sửa</button><button class="btn btn-danger" onclick="Ingredients.delete(${ing.IngrID})">Xóa</button></div></td>
                        </tr>
                    `).join('');
                    $('#ingredientsTable').innerHTML = renderTable(['ID','Tên','Đơn vị','Số lượng','Giá nhập','Trạng thái','Ghi chú','Thao tác'], rows);
                }
            })
            .catch(() => alert('Có lỗi khi tải danh sách nguyên liệu'));
    },
    edit(id) {
        fetchData(`modules/ingredients/ingredients.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const ing = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa nguyên liệu</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editIngredientForm" style="display: grid; gap: 10px;">
                                <div><label>Tên nguyên liệu:</label><input type="text" name="name" value="${ing.Name || ''}" required></div>
                                <div><label>Đơn vị:</label><input type="text" name="unit" value="${ing.Unit || ''}" required></div>
                                <div><label>Số lượng:</label><input type="number" name="quantity" value="${ing.StockQty || ''}" required></div>
                                <div><label>Giá nhập:</label><input type="number" name="price" value="${ing.PricePerUnit || ''}" required></div>
                                <div><label>Trạng thái:</label><select name="status"><option value="1" ${ing.Status==1?'selected':''}>Còn hàng</option><option value="0" ${ing.Status==0?'selected':''}>Hết hàng</option></select></div>
                                <div><label>Ghi chú:</label><textarea name="note">${ing.Note || ''}</textarea></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('ingredients')">Hủy</button>
                            </form>
                            <div id="formMessageEditIngredient"></div>
                        </div>
                    `;
                    $('#editIngredientForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditIngredient'), 'Đang xử lý...');
                        fetchData('modules/ingredients/ingredients.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditIngredient'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('ingredients'), 1000);
                                } else showMessage($('#formMessageEditIngredient'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditIngredient'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu nguyên liệu!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu nguyên liệu!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa nguyên liệu này?')) {
            fetchData(`modules/ingredients/ingredients.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa nguyên liệu thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa nguyên liệu'));
        }
    }
};

// =====================
// Invoices Module
// =====================
const Invoices = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý hóa đơn</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Tạo hóa đơn mới</h3>
                <form id="invoiceForm" style="display: grid; gap: 10px;">
                    <div><label>Mã khách hàng:</label><input type="number" name="customerID" required></div>
                    <div><label>Mã nhân viên:</label><input type="number" name="employeeID" required></div>
                    <div><label>Ngày lập:</label><input type="datetime-local" name="dateCreated" required></div>
                    <div><label>Tổng tiền:</label><input type="number" name="totalAmount" required></div>
                    <div><label>Trạng thái:</label><select name="status"><option value="Đã thanh toán">Đã thanh toán</option><option value="Chờ">Chờ</option><option value="Hủy">Hủy</option></select></div>
                    <div><label>Ghi chú:</label><textarea name="note"></textarea></div>
                    <button type="submit" class="btn btn-primary">Tạo hóa đơn</button>
                </form>
                <div id="formMessageInvoice"></div>
            </div>
            <h3>Danh sách hóa đơn</h3>
            <div id="invoicesTable"></div>
        `;
        this.loadList();
        $('#invoiceForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessageInvoice'), 'Đang xử lý...');
            fetchData('modules/invoices/invoices.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessageInvoice'), 'Tạo hóa đơn thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessageInvoice'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessageInvoice'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/invoices/invoices.php')
            .then(data => {
                if (data.success) {
                    const rows = data.data.map(inv => `
                        <tr>
                            <td>${inv.InvoiceID}</td>
                            <td>${inv.CustomerID}</td>
                            <td>${inv.EmpID}</td>
                            <td>${inv.DateTime}</td>
                            <td>${Number(inv.TotalAmount).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${inv.PaymentStatus}</td>
                            <td>${inv.Notes || ''}</td>
                            <td><div class="action-buttons"><button class="btn btn-primary" onclick="Invoices.edit(${inv.InvoiceID})">Sửa</button><button class="btn btn-danger" onclick="Invoices.delete(${inv.InvoiceID})">Xóa</button></div></td>
                        </tr>
                    `).join('');
                    $('#invoicesTable').innerHTML = renderTable(['ID','Khách hàng','Nhân viên','Ngày lập','Tổng tiền','Trạng thái','Ghi chú','Thao tác'], rows);
                }
            })
            .catch(() => alert('Có lỗi khi tải danh sách hóa đơn'));
    },
    edit(id) {
        fetchData(`modules/invoices/invoices.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const inv = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa hóa đơn</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editInvoiceForm" style="display: grid; gap: 10px;">
                                <div><label>Mã khách hàng:</label><input type="number" name="customerID" value="${inv.CustomerID || ''}" required></div>
                                <div><label>Mã nhân viên:</label><input type="number" name="employeeID" value="${inv.EmpID || ''}" required></div>
                                <div><label>Ngày lập:</label><input type="datetime-local" name="dateCreated" value="${(inv.DateTime ? inv.DateTime.replace(' ','T') : '')}" required></div>
                                <div><label>Tổng tiền:</label><input type="number" name="totalAmount" value="${inv.TotalAmount || ''}" required></div>
                                <div><label>Trạng thái:</label><select name="status"><option value="Đã thanh toán" ${inv.PaymentStatus==='Đã thanh toán'?'selected':''}>Đã thanh toán</option><option value="Chờ" ${inv.PaymentStatus==='Chờ'?'selected':''}>Chờ</option><option value="Hủy" ${inv.PaymentStatus==='Hủy'?'selected':''}>Hủy</option></select></div>
                                <div><label>Ghi chú:</label><textarea name="note">${inv.Notes || ''}</textarea></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('invoices')">Hủy</button>
                            </form>
                            <div id="formMessageEditInvoice"></div>
                        </div>
                    `;
                    $('#editInvoiceForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditInvoice'), 'Đang xử lý...');
                        fetchData('modules/invoices/invoices.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditInvoice'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('invoices'), 1000);
                                } else showMessage($('#formMessageEditInvoice'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditInvoice'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu hóa đơn!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu hóa đơn!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa hóa đơn này?')) {
            fetchData(`modules/invoices/invoices.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa hóa đơn thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa hóa đơn'));
        }
    }
};

// =====================
// Orders Module
// =====================
const Orders = {
    render() {
        $('#mainContent').innerHTML = `
            <h2>Quản lý đơn hàng online</h2>
            <div class="card" style="margin-bottom: 20px;">
                <h3>Thêm đơn hàng online mới</h3>
                <form id="orderForm" style="display: grid; gap: 10px;">
                    <div><label>Mã khách hàng (UserID):</label><input type="number" name="userID" required></div>
                    <div><label>Mã đơn hàng:</label><input type="text" name="orderNumber" required></div>
                    <div><label>Thời gian đặt:</label><input type="datetime-local" name="orderTime" required></div>
                    <div><label>Địa chỉ giao hàng:</label><textarea name="deliveryAddress" required></textarea></div>
                    <div><label>Số điện thoại liên hệ:</label><input type="tel" name="contactPhone" required></div>
                    <div><label>Tên người nhận:</label><input type="text" name="contactName" required></div>
                    <div><label>Phí giao hàng:</label><input type="number" name="deliveryFee" value="0"></div>
                    <div><label>Tạm tính:</label><input type="number" name="subTotal" required></div>
                    <div><label>Giảm giá:</label><input type="number" name="discount" value="0"></div>
                    <div><label>Tổng tiền:</label><input type="number" name="totalAmount" required></div>
                    <div><label>Phương thức thanh toán:</label><select name="paymentMethod" required><option value="Tiền mặt">Tiền mặt</option><option value="Thẻ">Thẻ</option><option value="Chuyển khoản">Chuyển khoản</option><option value="Ví điện tử">Ví điện tử</option></select></div>
                    <div><label>Trạng thái thanh toán:</label><select name="paymentStatus"><option value="Chưa thanh toán">Chưa thanh toán</option><option value="Đã thanh toán">Đã thanh toán</option><option value="Thất bại">Thất bại</option></select></div>
                    <div><label>Trạng thái đơn hàng:</label><select name="orderStatus"><option value="Chờ xác nhận">Chờ xác nhận</option><option value="Đã xác nhận">Đã xác nhận</option><option value="Đang chuẩn bị">Đang chuẩn bị</option><option value="Đang giao">Đang giao</option><option value="Đã giao">Đã giao</option><option value="Đã hủy">Đã hủy</option></select></div>
                    <div><label>Ghi chú:</label><textarea name="notes"></textarea></div>
                    <button type="submit" class="btn btn-primary">Thêm đơn hàng</button>
                </form>
                <div id="formMessageOrder"></div>
            </div>
            <h3>Danh sách đơn hàng online</h3>
            <div id="ordersTable"></div>
        `;
        this.loadList();
        $('#orderForm').onsubmit = e => {
            e.preventDefault();
            const formData = new FormData(e.target);
            showMessage($('#formMessageOrder'), 'Đang xử lý...');
            fetchData('modules/orders/orders.php', { method: 'POST', body: formData })
                .then(data => {
                    if (data.success) {
                        showMessage($('#formMessageOrder'), 'Thêm đơn hàng thành công!', 'green');
                        e.target.reset();
                        this.loadList();
                    } else showMessage($('#formMessageOrder'), 'Có lỗi: ' + (data.message || 'Không xác định'), 'red');
                })
                .catch(() => showMessage($('#formMessageOrder'), 'Có lỗi khi gửi dữ liệu', 'red'));
        };
    },
    loadList() {
        fetchData('modules/orders/orders.php')
            .then(data => {
                if (data.success) {
                    const rows = data.data.map(ord => `
                        <tr>
                            <td>${ord.OrderID}</td>
                            <td>${ord.UserID}</td>
                            <td>${ord.OrderNumber}</td>
                            <td>${ord.OrderTime}</td>
                            <td>${ord.DeliveryAddress}</td>
                            <td>${ord.ContactPhone}</td>
                            <td>${ord.ContactName}</td>
                            <td>${Number(ord.DeliveryFee).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${Number(ord.SubTotal).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${Number(ord.Discount).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${Number(ord.TotalAmount).toLocaleString('vi-VN')} VNĐ</td>
                            <td>${ord.PaymentMethod}</td>
                            <td>${ord.PaymentStatus}</td>
                            <td>${ord.OrderStatus}</td>
                            <td>${ord.Notes || ''}</td>
                            <td><div class="action-buttons"><button class="btn btn-primary" onclick="Orders.edit(${ord.OrderID})">Sửa</button><button class="btn btn-danger" onclick="Orders.delete(${ord.OrderID})">Xóa</button></div></td>
                        </tr>
                    `).join('');
                    $('#ordersTable').innerHTML = renderTable(['ID','Mã KH','Mã đơn','Thời gian đặt','Địa chỉ','SĐT','Tên nhận','Phí ship','Tạm tính','Giảm giá','Tổng tiền','PTTT','TT thanh toán','TT đơn hàng','Ghi chú','Thao tác'], rows);
                }
            })
            .catch(() => alert('Có lỗi khi tải danh sách đơn hàng online'));
    },
    edit(id) {
        fetchData(`modules/orders/orders.php?id=${id}`)
            .then(data => {
                if (data.success && data.data) {
                    const ord = data.data;
                    $('#mainContent').innerHTML = `
                        <h2>Sửa đơn hàng online</h2>
                        <div class="card" style="margin-bottom: 20px;">
                            <form id="editOrderForm" style="display: grid; gap: 10px;">
                                <div><label>Mã khách hàng (UserID):</label><input type="number" name="userID" value="${ord.UserID || ''}" required></div>
                                <div><label>Mã đơn hàng:</label><input type="text" name="orderNumber" value="${ord.OrderNumber || ''}" required></div>
                                <div><label>Thời gian đặt:</label><input type="datetime-local" name="orderTime" value="${(ord.OrderTime ? ord.OrderTime.replace(' ','T') : '')}" required></div>
                                <div><label>Địa chỉ giao hàng:</label><textarea name="deliveryAddress">${ord.DeliveryAddress || ''}</textarea></div>
                                <div><label>Số điện thoại liên hệ:</label><input type="tel" name="contactPhone" value="${ord.ContactPhone || ''}" required></div>
                                <div><label>Tên người nhận:</label><input type="text" name="contactName" value="${ord.ContactName || ''}" required></div>
                                <div><label>Phí giao hàng:</label><input type="number" name="deliveryFee" value="${ord.DeliveryFee || ''}" required></div>
                                <div><label>Tạm tính:</label><input type="number" name="subTotal" value="${ord.SubTotal || ''}" required></div>
                                <div><label>Giảm giá:</label><input type="number" name="discount" value="${ord.Discount || ''}" required></div>
                                <div><label>Tổng tiền:</label><input type="number" name="totalAmount" value="${ord.TotalAmount || ''}" required></div>
                                <div><label>Phương thức thanh toán:</label><select name="paymentMethod"><option value="Tiền mặt" ${ord.PaymentMethod==='Tiền mặt'?'selected':''}>Tiền mặt</option><option value="Thẻ" ${ord.PaymentMethod==='Thẻ'?'selected':''}>Thẻ</option><option value="Chuyển khoản" ${ord.PaymentMethod==='Chuyển khoản'?'selected':''}>Chuyển khoản</option><option value="Ví điện tử" ${ord.PaymentMethod==='Ví điện tử'?'selected':''}>Ví điện tử</option></select></div>
                                <div><label>Trạng thái thanh toán:</label><select name="paymentStatus"><option value="Chưa thanh toán" ${ord.PaymentStatus==='Chưa thanh toán'?'selected':''}>Chưa thanh toán</option><option value="Đã thanh toán" ${ord.PaymentStatus==='Đã thanh toán'?'selected':''}>Đã thanh toán</option><option value="Thất bại" ${ord.PaymentStatus==='Thất bại'?'selected':''}>Thất bại</option></select></div>
                                <div><label>Trạng thái đơn hàng:</label><select name="orderStatus"><option value="Chờ xác nhận" ${ord.OrderStatus==='Chờ xác nhận'?'selected':''}>Chờ xác nhận</option><option value="Đã xác nhận" ${ord.OrderStatus==='Đã xác nhận'?'selected':''}>Đã xác nhận</option><option value="Đang chuẩn bị" ${ord.OrderStatus==='Đang chuẩn bị'?'selected':''}>Đang chuẩn bị</option><option value="Đang giao" ${ord.OrderStatus==='Đang giao'?'selected':''}>Đang giao</option><option value="Đã giao" ${ord.OrderStatus==='Đã giao'?'selected':''}>Đã giao</option><option value="Đã hủy" ${ord.OrderStatus==='Đã hủy'?'selected':''}>Đã hủy</option></select></div>
                                <div><label>Ghi chú:</label><textarea name="notes">${ord.Notes || ''}</textarea></div>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn" onclick="loadContent('orders')">Hủy</button>
                            </form>
                            <div id="formMessageEditOrder"></div>
                        </div>
                    `;
                    $('#editOrderForm').onsubmit = function(e) {
                        e.preventDefault();
                        const formData = new FormData(this);
                        formData.append('id', id);
                        showMessage($('#formMessageEditOrder'), 'Đang xử lý...');
                        fetchData('modules/orders/orders.php', { method: 'PUT', body: new URLSearchParams([...formData]) })
                            .then(data => {
                                if (data.success) {
                                    showMessage($('#formMessageEditOrder'), 'Cập nhật thành công!', 'green');
                                    setTimeout(() => loadContent('orders'), 1000);
                                } else showMessage($('#formMessageEditOrder'), data.message || 'Có lỗi xảy ra', 'red');
                            })
                            .catch(() => showMessage($('#formMessageEditOrder'), 'Có lỗi khi gửi dữ liệu', 'red'));
                    };
                } else alert('Không tìm thấy dữ liệu đơn hàng!');
            })
            .catch(() => alert('Có lỗi khi lấy dữ liệu đơn hàng!'));
    },
    delete(id) {
        if (confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')) {
            fetchData(`modules/orders/orders.php?id=${id}`, { method: 'DELETE' })
                .then(data => {
                    if (data.success) {
                        alert('Xóa đơn hàng thành công!');
                        this.loadList();
                    } else alert('Lỗi: ' + data.message);
                })
                .catch(() => alert('Có lỗi khi xóa đơn hàng'));
        }
    }
};

// =====================
// Đăng xuất
// =====================
function logout() {
    fetch('auth/logout.php')
        .then(response => {
            if (response.ok) {
                localStorage.removeItem('user');
                localStorage.removeItem('role');
                window.location.href = 'auth/login.html';
            } else {
                alert('Có lỗi xảy ra khi đăng xuất');
            }
        })
        .catch(() => alert('Có lỗi xảy ra khi đăng xuất'));
}

// =====================
// Khởi động
// =====================
window.onload = loadDashboard; 