app.controller("POSSystemController", function ($scope, POSSystemService) {

    $scope.sampleArray = ['First', 'Second', 'Third'];

    $scope.userArray = [];
    $scope.showUpdateModal = false;

    //$scope.addFunc = function () {

    //    var userData = {
    //        "FirstName": $scope.FName,
    //        "LastName": $scope.LName,
    //        "Username": $scope.Username,
    //        "Password": $scope.Password,

    //    };
    //    $scope.userArray.push(userData);
    //    $scope.checkArray();
    //};
    //$scope.clearFunc = function () {
    //    $scope.FName = "";
    //    $scope.LName = "";
    //    $scope.Username = "";
    //    $scope.Password = "";

    //};


    //$scope.updateFunc = function (userIndex) {
    //    $scope.userArray[userIndex]["FirstName"] = $scope.FName;
    //    $scope.userArray[userIndex]["LastName"] = $scope.LName;
    //    $scope.userArray[userIndex]["Username"] = $scope.Username;
    //    $scope.userArray[userIndex]["Password"] = $scope.Password;
    //}

    //$scope.deleteFunc = function (userIndex) {
    //    $scope.userArray.splice(userIndex, 1);
    //    $scope.checkArray();
    //}

    //$scope.redirectFunc = function () {
    //    alert($scope.userArray.length);
    //    var userArrayString = JSON.stringify($scope.userArray);
    //    sessionStorage.setItem("UserArray", userArrayString);
    //    window.location.href = "/POS/LoginPage";

    //}
    //$scope.sessionParsing = function () {
    //    var userData = sessionStorage.getItem("UserArray");
    //    var jsonConverted = JSON.parse(userData);
    //    $scope.userArray = jsonConverted;
    //    alert($scope.userArray.length);
    //}

    //$scope.checkArray = function () {
    //    if ($scope.userArray.length >= 1) {
    //        $scope.showLogin = true;
    //    }
    //    else {
    //        $scope.showLogin = false;
    //    }
    //}
    //$scope.loginFunc = function () {
    //    var authenticate = $scope.userArray.find(
    //        items => items.Username == $scope.inputUsername && items.Password == $scope.inputPassword);
    //    if (authenticate != undefined) {
    //        sessionStorage.setItem("userLoggedData", authenticate);
    //        alert("You have logged in")
    //        window.location.href = "/POS/dashboard";
    //    } else {
    //        alert("You Have Entered the Wrong Password or Username");
    //    }
    //}
    //$scope.sessionLogin = function () {
    //    var userData = sessionStorage.getItem("userLoggedData");
    //    $scope.Data = userData;
    //}
    $scope.inputUsername = "";
    $scope.inputPassword = "";

    $scope.loginFunc = function () {
        var loginData = {
            username: $scope.inputUsername,
            password: $scope.inputPassword
        };

        if (!$scope.inputUsername || !$scope.inputPassword) {
            alert("Please enter username and password.");
            return;
        }

        POSSystemService.loginService(loginData).then(function (response) {
            if (response.data.success) {
                localStorage.setItem("userID", response.data.userID);
                localStorage.setItem("roleID", response.data.roleID);
                localStorage.setItem("full_name", response.data.full_name);
                localStorage.setItem("username", response.data.username);

                alert(response.data.message);
                window.location.href = "/POS/dashboard";
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.checkAdminLoginFunc = function () {
        var userID = localStorage.getItem("userID");
        var roleID = localStorage.getItem("roleID");

        if (!userID || roleID != "1") {
            window.location.href = "/POS/LoginPage";
            return;
        }

        $scope.currentUserID = localStorage.getItem("userID");
        $scope.currentRoleID = localStorage.getItem("roleID");
        $scope.currentFullName = localStorage.getItem("full_name");
        $scope.currentUsername = localStorage.getItem("username");
    };
    $scope.logoutFunc = function () {
        Swal.fire({
            icon: "question",
            title: "Logout?",
            text: "Are you sure you want to logout?",
            showCancelButton: true,
            confirmButtonText: "Logout",
            cancelButtonText: "Cancel",
            confirmButtonColor: "#8d6e63",
            cancelButtonColor: "#d4a373"
        }).then(function (result) {
            if (result.isConfirmed) {
                localStorage.removeItem("userID");
                localStorage.removeItem("roleID");
                localStorage.removeItem("full_name");
                localStorage.removeItem("username");

                window.location.href = "/POS/LoginPage";
            }
        });
    };
    $scope.customers = [];

    $scope.userID = 0;
    $scope.RoleID = "2";
    $scope.FullName = "";
    $scope.Email = "";
    $scope.ContactNumber = "";
    $scope.Username = "";
    $scope.Password = "";
    $scope.Status = "Active";

    $scope.initDashboardPageFunc = function () {
        $scope.getCardOrdersFunc();
        $scope.getCardCustomersFunc();
        $scope.getCardRevenueFunc();
        $scope.getCustomersFunc();

        $scope.getLineChartRevenueFunc();
        $scope.getBarChartCustomersFunc();
        $scope.getPieChartPaymentMethodFunc();
    };

    $scope.goTo = function(path) {
        window.location.href = "/POS/" + path;
    }
    $scope.addFunc = function () {
        if (!$scope.RoleID) {
            Swal.fire({
                icon: "warning",
                title: "Role Required",
                text: "Please select a role."
            });
            return;
        }

        if (!$scope.FullName || $scope.FullName.trim() === "") {
            Swal.fire({
                icon: "warning",
                title: "Full Name Required",
                text: "Please enter full name."
            });
            return;
        }

        if ($scope.FullName.length > 50) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Full Name",
                text: "Full name must not exceed 50 characters."
            });
            return;
        }

        if (!$scope.Email || $scope.Email.trim() === "") {
            Swal.fire({
                icon: "warning",
                title: "Email Required",
                text: "Please enter email address."
            });
            return;
        }

        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test($scope.Email)) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Email",
                text: "Please enter a valid email address."
            });
            return;
        }

        if ($scope.Email.length > 50) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Email",
                text: "Email must not exceed 50 characters."
            });
            return;
        }

        if (!$scope.ContactNumber || $scope.ContactNumber.trim() === "") {
            Swal.fire({
                icon: "warning",
                title: "Contact Required",
                text: "Please enter contact number."
            });
            return;
        }

        if ($scope.ContactNumber.length > 11) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Contact Number",
                text: "Contact number must not exceed 11 characters."
            });
            return;
        }

        if (!$scope.Username || $scope.Username.trim() === "") {
            Swal.fire({
                icon: "warning",
                title: "Username Required",
                text: "Please enter username."
            });
            return;
        }

        if ($scope.Username.length > 50) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Username",
                text: "Username must not exceed 50 characters."
            });
            return;
        }

        if (!$scope.Password || $scope.Password.trim() === "") {
            Swal.fire({
                icon: "warning",
                title: "Password Required",
                text: "Please enter password."
            });
            return;
        }

        if ($scope.Password.length > 255) {
            Swal.fire({
                icon: "warning",
                title: "Invalid Password",
                text: "Password must not exceed 255 characters."
            });
            return;
        }

        if (!$scope.Status) {
            Swal.fire({
                icon: "warning",
                title: "Status Required",
                text: "Please select status."
            });
            return;
        }

        var userData = {
            roleID: parseInt($scope.RoleID),
            full_name: $scope.FullName.trim(),
            email: $scope.Email.trim(),
            contact_number: $scope.ContactNumber.trim(),
            username: $scope.Username.trim(),
            password: $scope.Password,
            status: $scope.Status || "Active"
        };

        var saveUser = POSSystemService.saveUserService(userData, $scope.userID);

        saveUser.then(function (response) {
            if (response.data.success) {
                Swal.fire({
                    icon: "success",
                    title: "Success",
                    text: response.data.message
                }).then(function () {
                    $scope.clearUserFunc();
                    $scope.getCustomersFunc();
                    $scope.getCardCustomersFunc();
                    $scope.getBarChartCustomersFunc();

                    $scope.showUpdateModal = false;
                    $scope.$applyAsync();
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: response.data.message
                });
            }
        });
    };
    $scope.closeUpdateModalFunc = function () {
        $scope.showUpdateModal = false;
        $scope.clearUserFunc();
    };
    $scope.updateCustomerModalFunc = function (customer) {
        $scope.userID = customer.userID;
        $scope.RoleID = customer.roleID.toString();
        $scope.FullName = customer.full_name;
        $scope.Email = customer.email;
        $scope.ContactNumber = customer.contact_number;
        $scope.Username = customer.username;
        $scope.Password = customer.password;
        $scope.Status = customer.status;

        $scope.showUpdateModal = true;
    };
    $scope.deleteUserFunc = function (user) {
        Swal.fire({
            icon: "warning",
            title: "Delete Customer?",
            text: "Are you sure you want to delete " + user.full_name + "?",
            showCancelButton: true,
            confirmButtonText: "Yes, delete",
            cancelButtonText: "Cancel",
            confirmButtonColor: "#8d6e63",
            cancelButtonColor: "#d4a373"
        }).then(function (result) {
            if (result.isConfirmed) {
                POSSystemService.deleteUserService(user.userID).then(function (response) {
                    if (response.data.success) {
                        Swal.fire({
                            icon: "success",
                            title: "Deleted",
                            text: response.data.message
                        }).then(function () {
                            $scope.getCustomersFunc();
                            $scope.getCardCustomersFunc();
                            $scope.getBarChartCustomersFunc();
                            $scope.$applyAsync();
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            text: response.data.message
                        });
                    }
                });
            }
        });
    };
    $scope.clearUserFunc = function () {
        $scope.userID = 0;
        $scope.RoleID = "";
        $scope.FullName = "";
        $scope.Email = "";
        $scope.ContactNumber = "";
        $scope.Username = "";
        $scope.Password = "";
        $scope.Status = "Active";
    };
    $scope.getCustomersFunc = function () {
        POSSystemService.getCustomersService().then(function (response) {
            if (response.data.success) {
                $scope.customers = response.data.customers;
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.getCardOrdersFunc = function () {
        POSSystemService.getCardOrdersService().then(function (response) {
            if (response.data.success) {
                $scope.totalOrders = response.data.totalOrders;
            } else {
                alert(response.data.message);
            }
        });
    };

    $scope.getCardCustomersFunc = function () {
        POSSystemService.getCardCustomersService().then(function (response) {
            if (response.data.success) {
                $scope.totalCustomers = response.data.totalCustomers;
            } else {
                alert(response.data.message);
            }
        });
    };

    $scope.getCardRevenueFunc = function () {
        POSSystemService.getCardRevenueService().then(function (response) {
            if (response.data.success) {
                $scope.totalRevenue = response.data.totalRevenue;
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.lineChartLabels = [];
    $scope.lineChartData = [];
    $scope.lineChartSeries = ["Revenue"];
    $scope.lineChartColors = ["#ff8fab"];

    $scope.barChartLabels = [];
    $scope.barChartData = [];
    $scope.barChartSeries = ["Registered Customers"];
    $scope.barChartColors = ["#d4a373"];

    $scope.pieChartLabels = [];
    $scope.pieChartData = [];
    $scope.pieChartColors = ["#d4a373", "#c8b6a6", "#f3c4a9", "#a5a58d", "#8d6e63"];

    $scope.getLineChartRevenueFunc = function () {
        POSSystemService.getLineChartRevenueService().then(function (response) {
            if (response.data.success) {
                $scope.lineChartLabels = response.data.lineChart.LineLabels;
                $scope.lineChartData = [
                    response.data.lineChart.LineData
                ];
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.getBarChartCustomersFunc = function () {
        POSSystemService.getBarChartCustomersService().then(function (response) {
            if (response.data.success) {
                $scope.barChartLabels = response.data.barChart.BarLabels;
                $scope.barChartData = [
                    response.data.barChart.BarData
                ];
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.getPieChartPaymentMethodFunc = function () {
        POSSystemService.getPieChartPaymentMethodService().then(function (response) {
            if (response.data.success) {
                $scope.pieChartLabels = response.data.pieChart.PieLabels;
                $scope.pieChartData = response.data.pieChart.PieData;
            } else {
                alert(response.data.message);
            }
        });
    };
    $scope.lineChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: true,
            labels: {
                fontColor: "#6d4c41"
            }
        },
        scales: {
            xAxes: [{
                ticks: {
                    fontColor: "#6d4c41"
                },
                gridLines: {
                    color: "#e6d8c8"
                }
            }],
            yAxes: [{
                ticks: {
                    fontColor: "#6d4c41",
                    beginAtZero: true
                },
                gridLines: {
                    color: "#e6d8c8"
                }
            }]
        }
    };

    $scope.barChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: true,
            labels: {
                fontColor: "#6d4c41"
            }
        },
        scales: {
            xAxes: [{
                ticks: {
                    fontColor: "#6d4c41"
                },
                gridLines: {
                    color: "#e6d8c8"
                }
            }],
            yAxes: [{
                ticks: {
                    fontColor: "#6d4c41",
                    beginAtZero: true,
                    precision: 0
                },
                gridLines: {
                    color: "#e6d8c8"
                }
            }]
        }
    };

    $scope.pieChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#6d4c41"
            }
        }
    };
    
});