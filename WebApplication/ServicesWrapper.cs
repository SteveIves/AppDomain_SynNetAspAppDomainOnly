using System;
using System.Web;
using System.IO;
using BusinessLogic;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;

namespace WebApplication
{
    /* 
     * This class provides an AppDomain protection wrapper for the
     * Synergy .NET code in the Services class. It is CRITICAL that
     * the Web application ALWAYS calls the methods exposed by the
     * Services class via an instance of the ServicesWrapper class.
     * The ServicesWrapper class should NEVER be persisted beyond
     * a single page instance, and the Dispose method should be called.
     * The best way to achieve this is to use a pattern like this:
     * 
     *      using (var servicesWrapper = new ServicesWrapper())
     *      {
     *          result = servicesWrapper.Services.SomeMethod(params)
     *      
     *          //Other code
     * 
     *      }
     */

    class ServicesWrapper : IDisposable
    {
        AppDomain _domain;
        public Services Services;

        public ServicesWrapper()
        {
            //Create an AppDomain
            _domain = AppDomainUtil.GetThreadAppDomain();
            //And load the Synergy .NET business logic INTO the AppDomain
            Services = _domain.CreateInstanceFromAndUnwrap(typeof(Services).Assembly.CodeBase, typeof(Services).FullName) as Services;
        }

        public void Dispose()
        {
            _domain = null;
            Services = null;
            AppDomainUtil.ThreadCleanup();
        }
    }
    
    public static class AppDomainUtil
    {
        //Maintain a cache of AppDomains, keyed by the ID of the thread the AppDomain is associated with.
        //This means we can use the same AppDomain each time in a given thread, avoiding the overhead
        //of creating a brand new AppDomain every time we need one.
        public static Dictionary<Thread, AppDomain> _activeDomains = new Dictionary<Thread, AppDomain>();

        /// <summary>
        /// This methos is used to retrieve the AppDomain that is associated with the current thread.
        /// If there is no AppDomain associated with the thread then a new one will be created.
        /// </summary>
        /// <returns>AppDomain for use by current thread.</returns>
        public static AppDomain GetThreadAppDomain()
        {
            //Make sure only one thread can go through this logic at the same time. Others will wait.
            lock (_activeDomains)
            {
                //Is there an AppDomain associated with the current thread?
                if (_activeDomains.ContainsKey(Thread.CurrentThread))
                {
                    //Yes, return it
                    return _activeDomains[Thread.CurrentThread];
                }
                else
                {
                    //No, return a new one
                    var domain = AppDomain.CreateDomain(Guid.NewGuid().ToString());
                    _activeDomains.Add(Thread.CurrentThread, domain);
                    return domain;
                }
            }
        }

        /// <summary>
        /// This method cleans up the AppDomain cache. It removes the AppDomain entry
        /// for any thread that no longer exists. The method is called each time a
        /// ServicesWrapper instance is disposed.
        /// </summary>
        public static void ThreadCleanup()
        {
            //Make sure only one thread can go through this logic at the same time. Others will wait.
            lock (_activeDomains)
            {
                foreach (var item in _activeDomains.Where(tpl => !tpl.Key.IsAlive).ToList())
                {
                    AppDomain.Unload(item.Value);
                    _activeDomains.Remove(item.Key);
                }
            }
        }

    }

}