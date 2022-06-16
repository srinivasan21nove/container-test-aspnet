using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace MyWebApp.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }
    public void OnGet()
    {
    }
     public string GetMachineName()
    {
    try{
    return "Machine: " + System.Environment.Machine;
    }
    catch{
    return "unable to retrice system details";
    }
       
    }
}
