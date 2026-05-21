using POSSystem.Models.Maps;
using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Context
{
    public class db_context : DbContext
    {
        public db_context() : base("thrift_shop_db")
        {
        }

        public virtual DbSet<tbl_user> tbl_user { get; set; }
        public virtual DbSet<tbl_product> tbl_product { get; set; }
        public virtual DbSet<tbl_order> tbl_order { get; set; }
        public virtual DbSet<tbl_payment> tbl_payment { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new user_maps());
            modelBuilder.Configurations.Add(new product_maps());
            modelBuilder.Configurations.Add(new order_maps());
            modelBuilder.Configurations.Add(new payment_maps());

            base.OnModelCreating(modelBuilder);
        }
    }
}