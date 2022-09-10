using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;

namespace WebApplication
{
    public partial class PartsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var servicesWrapper = new ServicesWrapper())
            {
                List<Part> parts;
                string errorMessage;
                switch (servicesWrapper.Services.ReadAllParts(out parts, out errorMessage))
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