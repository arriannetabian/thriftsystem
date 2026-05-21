using POSSystem.Models;
using POSSystem.Models.Context;
using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace POSSystem.Controllers
{
    public class POSController : Controller
    {
        
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult Registrationpage()
        {
            return View();
        }

        public ActionResult LoginPage()
        {
            return View();
        }
        public ActionResult FrontPage()
        {
            return View();
        }
        public ActionResult dashboard()
        {
            return View();
        }
        [HttpPost]
        public JsonResult SaveUser(tbl_user data, int? id)
        {
            try
            {
                using (var connect = new db_context())
                {
                    var existingUser = connect.tbl_user
                        .FirstOrDefault(x => x.userID == id);

                    if (existingUser != null)
                    {
                        existingUser.roleID = data.roleID;
                        existingUser.full_name = data.full_name;
                        existingUser.email = data.email;
                        existingUser.contact_number = data.contact_number;
                        existingUser.username = data.username;
                        existingUser.password = data.password;
                        existingUser.status = data.status;
                        existingUser.updatedAt = DateTime.Now;

                        connect.SaveChanges();

                        return Json(new
                        {
                            success = true,
                            message = "User updated successfully."
                        });
                    }
                    else
                    {
                        data.createdAt = DateTime.Now;
                        data.updatedAt = DateTime.Now;

                        connect.tbl_user.Add(data);
                        connect.SaveChanges();

                        return Json(new
                        {
                            success = true,
                            message = "User saved successfully."
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                });
            }
        }
        [HttpGet]
        public JsonResult GetCardOrders()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var totalOrders = connect.tbl_order.Count();

                    return Json(new
                    {
                        success = true,
                        totalOrders = totalOrders
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetCardCustomers()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var totalCustomers = connect.tbl_user
                        .Where(x => x.roleID == 2)
                        .Count();

                    return Json(new
                    {
                        success = true,
                        totalCustomers = totalCustomers
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetCardRevenue()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var totalRevenue = connect.tbl_payment
                        .Where(x => x.payment_status == 0)
                        .Select(x => (decimal?)x.payment_amount)
                        .Sum() ?? 0;

                    return Json(new
                    {
                        success = true,
                        totalRevenue = totalRevenue
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpGet]
        public JsonResult GetCustomers()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var customers = connect.tbl_user
                        .Where(x => x.roleID == 2)
                        .ToList()
                        .Select(x => new
                        {
                            x.userID,
                            x.roleID,
                            x.full_name,
                            x.email,
                            x.contact_number,
                            x.username,
                            x.password,
                            x.status,
                            createdAt = x.createdAt.HasValue ? x.createdAt.Value.ToString("yyyy-MM-dd") : ""
                        })
                        .ToList();

                    return Json(new
                    {
                        success = true,
                        customers = customers
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult DeleteUser(int id)
        {
            try
            {
                using (var connect = new db_context())
                {
                    var user = connect.tbl_user
                        .FirstOrDefault(x => x.userID == id);

                    if (user == null)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Customer not found."
                        });
                    }

                    connect.tbl_user.Remove(user);
                    connect.SaveChanges();

                    return Json(new
                    {
                        success = true,
                        message = "Customer deleted successfully."
                    });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                });
            }
        }
        [HttpGet]
        public JsonResult GetLineChartRevenue()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var result = connect.tbl_payment
                        .Where(x => x.payment_status == 0)
                        .ToList()
                        .GroupBy(x => x.payment_date.HasValue ? x.payment_date.Value.ToString("yyyy-MM-dd") : "No Date")
                        .Select(x => new
                        {
                            Date = x.Key,
                            Total = x.Sum(y => y.payment_amount)
                        })
                        .OrderBy(x => x.Date)
                        .ToList();

                    var chart = new LineChart
                    {
                        LineLabels = result.Select(x => x.Date).ToList(),
                        LineData = result.Select(x => x.Total).ToList()
                    };

                    return Json(new
                    {
                        success = true,
                        lineChart = chart
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetBarChartCustomers()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var result = connect.tbl_user
                        .Where(x => x.roleID == 2)
                        .ToList()
                        .GroupBy(x => x.createdAt.HasValue ? x.createdAt.Value.ToString("yyyy-MM-dd") : "No Date")
                        .Select(x => new
                        {
                            Date = x.Key,
                            Total = x.Count()
                        })
                        .OrderBy(x => x.Date)
                        .ToList();

                    var chart = new BarChart
                    {
                        BarLabels = result.Select(x => x.Date).ToList(),
                        BarData = result.Select(x => x.Total).ToList()
                    };

                    return Json(new
                    {
                        success = true,
                        barChart = chart
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetPieChartPaymentMethod()
        {
            try
            {
                using (var connect = new db_context())
                {
                    var result = connect.tbl_payment
                        .ToList()
                        .GroupBy(x => x.payment_method)
                        .Select(x => new
                        {
                            PaymentMethod = x.Key,
                            Total = x.Count()
                        })
                        .ToList();

                    var chart = new PieChart
                    {
                        PieLabels = result.Select(x => x.PaymentMethod).ToList(),
                        PieData = result.Select(x => x.Total).ToList()
                    };

                    return Json(new
                    {
                        success = true,
                        pieChart = chart
                    }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public JsonResult Login(tbl_user data)
        {
            try
            {
                using (var connect = new db_context())
                {
                    var user = connect.tbl_user
                        .FirstOrDefault(x => x.username == data.username && x.password == data.password);

                    if (user == null)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Invalid username or password."
                        });
                    }

                    if (user.status != "Active")
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Your account is inactive."
                        });
                    }

                    if (user.roleID != 1)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Only admin accounts can login."
                        });
                    }

                    return Json(new
                    {
                        success = true,
                        message = "Login successful.",
                        userID = user.userID,
                        roleID = user.roleID,
                        full_name = user.full_name,
                        username = user.username
                    });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ErrorHandling(ex)
                });
            }
        }

        public string ErrorHandling(Exception ex)
        {
            var errorMessage = $@"
              ===== ERROR DETAILS =====
              Message        : {ex.Message}
              Type           : {ex.GetType().FullName}
              Source         : {ex.Source}
              Stack Trace    : {ex.StackTrace}
              Inner Exception: {(ex.InnerException != null ? ex.InnerException.Message : "None")}
              Timestamp      : {DateTime.Now:yyyy-MM-dd HH:mm:ss}
              =========================";

            return errorMessage;
        }

    }
}