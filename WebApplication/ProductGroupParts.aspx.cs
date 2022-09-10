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
    public partial class ProductGroupParts : System.Web.UI.Page
    {
        private string productGroup;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var servicesWrapper = new ServicesWrapper())
            {
                productGroup = Request.QueryString["productGroup"];
                List<Part> parts;
                string errorMessage;
                switch (servicesWrapper.Services.GetProductGroupParts(productGroup, out parts, out errorMessage))
                {
                    case MethodStatus.Success:
                        grid.DataSource = parts;
                        grid.DataBind();
                        lblMessage.Text = String.Format("{0} matching parts", parts.Count);
                        break;
                    case MethodStatus.FatalError:
                        lblMessage.Text = String.Format("Fatal error {0}",errorMessage);
                        break;
                }
            }
        }

    }
}