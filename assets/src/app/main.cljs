(ns app.main
  (:require
   ["phoenix_html" :as phoenix_html]
   ["phoenix" :refer [Socket]]
   ["phoenix_live_view" :refer [LiveSocket]]))

(def csrf-token (-> "meta[name='csrf-token']"
                    (js/document.querySelector)
                    (.getAttribute "content")))

(def live-socket-params
  (clj->js {:params {:_csrf_token csrf-token}}))

(set!
 (.. js/window -liveSocket)
 (LiveSocket. "/live" Socket live-socket-params))

(def live-socket (.. js/window -liveSocket))

(defn main! []
  (.connect live-socket))