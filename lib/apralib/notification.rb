module ApraService

  class Notification

    attr_accessor :purpose, :purpose_description, :expense_amount, :expense_description,
                  :grant_date, :granted_to_group, :amount, :grantee, :work_start_date,
                  :work_end_date, :reference, :work_duration_months, :work_duration_days,
                  :work_duration_years, :ignore_work_duration

    NON_NILLABLE_KEYS = [:purpose, :expense_amount, :grant_date, :granted_to_group, :work_duration_months,
                        :work_duration_days, :work_duration_years, :grantee, :amount, :ignore_work_duration]


    def initialize
      @ignore_work_duration = false
      @granted_to_group = false
      @work_duration_days = 0
      @work_duration_months = 0
      @work_duration_years = 0
      @expense_amount = 0
    end

    def to_hash
      NON_NILLABLE_KEYS.each do |key|
        raise RuntimeError, "Variable #{key.to_s} cannot be nil" if self.instance_variable_get("@#{key.to_s}").nil?
      end
      result = {}
      result[:kayttotarkoitus] = purpose
      result[:kayttotarkoitustarkenne] = purpose_description if purpose_description
      result[:kuluosuusrahamaara] = expense_amount
      result[:kuluosuusteksti] = expense_description if expense_description
      result[:myontopaatoksen_antopvm] = grant_date.rfc3339
      result[:onko_myonnetty_tyoryhmalle] = granted_to_group
      result[:rahamaara] = amount
      result[:saajatiedot] = grantee.to_hash
      result[:sisaltaako_kuluja] = (expense_amount > 0)

      if ignore_work_duration
        result[:tyon_kesto_kuukausia] = 0
        result[:tyon_kesto_paivia] = 0
        result[:tyon_kesto_vuosia] = 0
      else
        result[:tyon_kesto_kuukausia] = work_duration_months
        result[:tyon_kesto_paivia] = work_duration_days
        result[:tyon_kesto_vuosia] = work_duration_years
      end
      result[:tyonkestoeikantaa] = ignore_work_duration
      result[:tyoskentelyn_alkamispvm] = work_start_date.rfc3339 if work_start_date
      result[:tyoskentelyn_paattymispvm] = work_end_date.rfc3339 if work_end_date
      result[:viite] = reference
      result

    end

    def self.from_hash(hash)
      notification = Notification.new
      notification.purpose = hash[:kayttotarkoitus]
      notification.purpose_description = hash[:kayttotarkoitustarkenne]
      notification.expense_amount = hash[:kuluosuusrahamaara]
      notification.expense_description = hash[:kuluosuusteksti]
      notification.grant_date = hash[:myontopaatoksen_antopvm]
      notification.granted_to_group = hash[:onko_myonnetty_tyoryhmalle]
      notification.amount = hash[:rahamaara]
      notification.grantee = Grantee.from_hash(hash[:saajatiedot])
      notification.work_duration_months = hash[:tyon_kesto_kuukausia]
      notification.work_duration_days = hash[:tyon_kesto_paivia]
      notification.work_duration_years = hash[:tyon_kesto_vuosia]
      notification.ignore_work_duration = hash[:tyonkestoeikantaa]
      notification.work_start_date = hash[:tyoskentelyn_alkamispvm]
      notification.work_end_date = hash[:tyoskentelyn_paattymispvm]
      notification.reference = hash[:viite]
      notification
    end


  end


end