import React from "react";

import { Icon } from "@chakra-ui/react";
import {
  MdBarChart,
  MdPerson,
  MdHome,
  MdLock,
  MdQueryStats,
  MdOutlineShoppingCart,
  MdLocationPin,
  MdSource,
} from "react-icons/md";

// Admin Imports
import MainDashboard from "views/admin/default";
import ResourcesDashboard from "views/admin/resources";
import statsDashboard from "views/admin/stats";
import OptimizedDashboard from "views/admin/Optimization";
// Auth Imports
import SignInCentered from "views/auth/signIn";

//users 
import rtlDashboard from "views/rtl/default";

const routes = [
  {
    name: "Resources",
    layout: "/admin",
    path: "/resources",
    icon: <Icon as={MdSource} width='20px' height='20px' color='inherit' />,
    component: ResourcesDashboard,
  },
  {
    name: "Bin Locations",
    layout: "/admin",
    path: "/default",
    icon: <Icon as={MdQueryStats} width='20px' height='20px' color='inherit' />,
    component: MainDashboard,
  },
  {
    name: "Statistics",
    layout: "/admin",
    path: "/stats",
    icon: <Icon as={MdLocationPin} width='20px' height='20px' color='inherit' />,
    component: statsDashboard,
  },
  {
    name: "Optimization",
    layout: "/admin",
    path: "/optimize",
    icon: <Icon as={MdLock} width='20px' height='20px' color='inherit' />,
    component: OptimizedDashboard,
  },
  {
    name: "Sign In",
    layout: "/auth",
    path: "/sign-in",
    icon: <Icon as={MdLock} width='20px' height='20px' color='inherit' />,
    component: SignInCentered,
  },

  
];

export default routes;
