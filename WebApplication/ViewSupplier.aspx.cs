using BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class ViewSupplier : System.Web.UI.Page
    {
        String supplierId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                lblErrorMessage.Text = "";
            }
            else
            {
                supplierId = Request.QueryString["id"];
                try
                {
                    using (var servicesWrapper = new ServicesWrapper())
                    {
                        Supplier supplier;
                        String grfa;
                        String errorMessage;
                        switch (servicesWrapper.Services.ReadSupplier(supplierId, out supplier, out grfa, out errorMessage))
                        {
                            case MethodStatus.Success:
                                showSupplier(supplier, grfa);
                                break;
                            case MethodStatus.FatalError:
                                lblErrorMessage.Text = String.Format("Fatal error {0}",errorMessage);
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblErrorMessage.Text = "Service method call failed with error: " + ex.Message;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Suppliers.aspx", false);
        }

        private void showSupplier(Supplier supplier, String grfa)
        {
            txtSupplierId.Text = supplier.SupplierId;
            txtName.Text = supplier.Name;
            txtAddress1.Text = supplier.Address1;
            txtAddress2.Text = supplier.Address2;
            txtAddress3.Text = supplier.Address3;
            txtCity.Text = supplier.City;
            txtPostalCode.Text = supplier.PostalCode;
            txtWebAddress.Text = supplier.WebAddress;
        }

    }
}