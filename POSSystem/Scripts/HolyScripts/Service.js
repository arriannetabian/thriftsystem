app.service("POSSystemService", function ($http) {
    this.saveUserService = function (data, id) {
        var response = $http({
            url: "/POS/SaveUser",
            method: "POST",
            data: {
                data: data,
                id: id
            },
            headers: {
                "Content-Type": "application/json"
            }
        });

        return response;
    };
    this.getCardOrdersService = function () {
        return $http.get("/POS/GetCardOrders");
    };

    this.getCardCustomersService = function () {
        return $http.get("/POS/GetCardCustomers");
    };

    this.getCardRevenueService = function () {
        return $http.get("/POS/GetCardRevenue");
    };
    this.getCustomersService = function () {
        return $http.get("/POS/GetCustomers");
    };

  
    this.deleteUserService = function (id) {
        var response = $http({
            url: "/POS/DeleteUser",
            method: "POST",
            data: {
                id: id
            },
            headers: {
                "Content-Type": "application/json"
            }
        });

        return response;
    };
    this.loginService = function (data) {
        var response = $http({
            url: "/POS/Login",
            method: "POST",
            data: data,
            headers: {
                "Content-Type": "application/json"
            }
        });

        return response;
    };
    this.getLineChartRevenueService = function () {
        return $http.get("/POS/GetLineChartRevenue");
    };

    this.getBarChartCustomersService = function () {
        return $http.get("/POS/GetBarChartCustomers");
    };

    this.getPieChartPaymentMethodService = function () {
        return $http.get("/POS/GetPieChartPaymentMethod");
    };
});